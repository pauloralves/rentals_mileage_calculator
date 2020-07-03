class ChangeDistanceDefaultValueInCsvFile < ActiveRecord::Migration[6.0]
  def change
  		change_column :csv_files, :distance, :integer, :default => 0
  end
end
