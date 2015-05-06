class OfferCars < ActiveRecord::Migration
  def change
    create_table :offer_cars do |t|
      t.integer :car_id, :offer_id
    end
  end
end
