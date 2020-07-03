class CreateCsvFiles < ActiveRecord::Migration[6.0]
  def change
    create_table :csv_files do |t|
      t.integer :status
      t.integer :distance
      t.integer :rental_id

      t.timestamps
    end
    add_index :csv_files, :rental_id
  end
end
