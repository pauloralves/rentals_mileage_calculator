class ChangeLatitudeLongitudeTypeInCsvLine < ActiveRecord::Migration[6.0]
  def up
    change_column :csv_lines, :latitude, :float
    change_column :csv_lines, :longitude, :float
  end

  def down
	change_column :csv_lines, :latitude, :integer
    change_column :csv_lines, :longitude, :integer
  end
end
