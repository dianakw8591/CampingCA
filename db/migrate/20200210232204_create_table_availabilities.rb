class CreateTableAvailabilities < ActiveRecord::Migration[5.2]
  def change
    create_table :availabilities do |t|
      t.integer :campground_id
      t.date :date
      t.boolean :open?
      t.integer :sites_available
      # may need more columns for tracking updates - updated sites available, update time
    end
  end
end
