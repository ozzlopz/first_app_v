class Appuser < ActiveRecord::Base
  
  acts_as_xlsx

  
  
  belongs_to :car
  
  
 
  
  def self.to_csv
    CSV.generate do |csv|
      csv << column_names
      all.each do |appuser|
        csv <<  appuser.attributes.values_at(*column_names)
      end
    end
  end
   default_scope -> {order(modelId: :asc)}
end
