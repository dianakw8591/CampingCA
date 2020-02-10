class CreateTableRecAreas < ActiveRecord::Migration[5.2]
  def change
    create_table :rec_areas do |t|
      t.string :name
      t.integer :official_rec_area_id
      t.string :state_code
      t.string :description
    end
  end
end
