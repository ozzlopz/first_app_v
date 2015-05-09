class CreateAppusers < ActiveRecord::Migration
  def change
    create_table :appusers do |t|
      t.string :name
      t.string :first_last_name
      t.string :second_last_name
      t.string :lada
      t.string :phone
      t.string :email
      t.string :model
      t.string :serial_number
      t.timestamps
    end
  end
end
