class Calculator
   def initialize(csv_file)
      @csv_file = csv_file
      get_mileage
  end

  def get_mileage
    @csv_file.set_status(1)
    lines = @csv_file.csv_lines.order(:id)

    total_distance  = 0
    new_status = 2

    # Iterate through all the lines from the csv file
    (0..lines.size-2).each do |i|
      next if lines[i].latitude == lines[i+1].latitude && lines[i].longitude == lines[i+1].longitude
      
      api_response = get_oogle_api_response(lines[i], lines[i+1])

      if api_response == false
        new_status = 3
        total_distance = 0
        break
      end

      total_distance += get_distance(api_response)
    end

    @csv_file.set_status(new_status)

    @csv_file.distance = total_distance
    @csv_file.save!
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
end