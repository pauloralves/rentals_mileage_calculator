class CreateRentals < ActiveRecord::Migration[6.0]
  def change
    create_table :rentals do |t|
      t.string :name

      t.timestamps
    end
  end
end
