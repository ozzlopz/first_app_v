class AddModelIdToAppusers < ActiveRecord::Migration
  def change
    add_column :appusers, :modelId, :integer
  end
end
