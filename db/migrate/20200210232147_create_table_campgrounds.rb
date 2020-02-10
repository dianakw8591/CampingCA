class CreateTableCampgrounds < ActiveRecord::Migration[5.2]
  def change
    create_table :campgrounds do |t|
      t.string :name
      t.integer :official_facility_id
      t.string :description
      t.integer :rec_area_id
    end
  end
end
