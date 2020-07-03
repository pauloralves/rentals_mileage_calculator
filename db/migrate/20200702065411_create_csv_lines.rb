class CreateCsvLines < ActiveRecord::Migration[6.0]
  def change
    create_table :csv_lines do |t|
      t.integer :timestamp
      t.integer :latitude
      t.integer :longitude
      t.integer :csv_file_id

      t.timestamps
    end
    add_index :csv_lines, :csv_file_id
  end
end
