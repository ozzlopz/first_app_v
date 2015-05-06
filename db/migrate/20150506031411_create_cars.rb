class CreateCars < ActiveRecord::Migration
  def change
    create_table :cars do |t|
      t.string :name
    end
  end
end
