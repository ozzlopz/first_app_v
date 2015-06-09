class AddHasyearsToOffers < ActiveRecord::Migration
  def change
    add_column :offers, :hasyears, :boolean, default: false
  end
end
