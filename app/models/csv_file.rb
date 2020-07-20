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
end
