class CreateTableAlerts < ActiveRecord::Migration[5.2]
  def change
    create_table :alerts do |t|
      t.integer :campground_id
      t.integer :user_id
      t.date :start_date
      t.date :end_date
      t.boolean :has_triggered?, default: false
    end
  end
end
