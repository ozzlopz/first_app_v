class AddYearsToOffers < ActiveRecord::Migration
  def change
    add_column :offers, :min_year, :integer
    add_column :offers, :max_year, :integer
  end
end
