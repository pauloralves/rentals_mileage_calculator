class Rental < ApplicationRecord
	has_many :csv_files, dependent: :destroy
	validates :name,  :presence => true
	
	def total_mileage_km
		(self.csv_files.sum(&:distance)/1000.0).round(2)
	end

	def processed_csv_files
		self.csv_files.select{ |f| f.status == 2 }
	end

	def average_mileage_km
		processed_csv_files_size = self.processed_csv_files.size
		if processed_csv_files_size == 0
			"0.0"
		else
			(self.total_mileage_km / processed_csv_files_size).round(2)
		end
	end
end
