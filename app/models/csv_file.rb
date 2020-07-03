class CsvFile < ApplicationRecord
	belongs_to :rental
	has_many :csv_lines, dependent: :destroy

	# Creates csv_lines from a csf file
    def create_lines(file)
      file_content = file.read

      file_content.split(/[\r\n]+/).each do |line|
        next if line.empty?
      	create_line(line)
      end
    end

    # Creates each csv_line with the text of the line from the csv file
    def create_line(line)
      	csv_line = CsvLine.new(csv_file_id: id)

      	line_info = line.split("\;")
      	csv_line.timestamp = line_info[0].to_i
      	csv_line.latitude  = line_info[1].to_f
      	csv_line.longitude = line_info[2].to_f

      	csv_line.save!
    end

    def get_status
      case status
      when 0
        { string: "Waiting", class: "secondary" }
      when 1
        { string: "Processing", class: "warning" }
      when 2
        { string: "Processed", class: "success" }
      when 3
        { string: "Error", class: "danger" }
      end
    end

    def set_status(status)
      self.status = status
      self.save!
    end

    def get_oogle_api_response(origin, destination)
      uri = URI("https://maps.googleapis.com/maps/api/distancematrix/json")
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true

      origins = "#{origin.latitude},#{origin.longitude}"
      destinations = "#{destination.latitude},#{destination.longitude}"

      params = { origins: origins, destinations: destinations, language: "en", key: Rails.application.secrets.google_api_key }
      uri.query = URI.encode_www_form(params)
      response = Net::HTTP.get_response(uri)

      return false unless response.code == "200"

      body = JSON.parse(response.body)
    end

    def get_distance(api_response)
      api_response["rows"][0]["elements"][0]["distance"]["value"]
    end

    def calculate_mileage
      set_status(1)
      csv_lines = self.csv_lines.order(:id)
      total_distance  = 0
      new_status = 2
      # Iterate through all the lines from the csv file
      (0..csv_lines.size-2).each do |i|
        next if csv_lines[i].latitude == csv_lines[i+1].latitude && csv_lines[i].longitude == csv_lines[i+1].longitude
        
        api_response = get_oogle_api_response(csv_lines[i], csv_lines[i+1])

        if api_response == false
          new_status = 3
          total_distance = 0
          break
        end

        total_distance += get_distance(api_response)
      end

      set_status(new_status)

      self.distance = total_distance
      self.save!
    end
end
