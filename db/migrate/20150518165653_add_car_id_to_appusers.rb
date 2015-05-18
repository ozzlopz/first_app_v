class AddCarIdToAppusers < ActiveRecord::Migration
  def change
    add_column :appusers, :car_id, :integer
  end
end
