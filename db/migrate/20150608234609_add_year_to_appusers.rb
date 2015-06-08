class AddYearToAppusers < ActiveRecord::Migration
  def change
    add_column :appusers, :year, :integer
  end
end
