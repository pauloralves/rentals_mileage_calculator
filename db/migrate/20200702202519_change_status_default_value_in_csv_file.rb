class ChangeStatusDefaultValueInCsvFile < ActiveRecord::Migration[6.0]
  def change
  	change_column :csv_files, :status, :integer, :default => 0
  end
end
