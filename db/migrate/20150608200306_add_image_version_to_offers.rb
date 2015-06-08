class AddImageVersionToOffers < ActiveRecord::Migration
  def change
    add_column :offers, :image_version, :integer
  end
end
