class Appuser < ActiveRecord::Base
  
  acts_as_xlsx

  validates :name, presence: true, length:{minimum:3,maximum:40}
  validates :first_last_name, presence: true, length:{minimum:3,maximum:40}
  validates :second_last_name, presence: true, length:{minimum:3,maximum:40}
  validates :lada, presence: true, length:{minimum:3,maximum:40}
  validates :phone, presence: true, length:{minimum:3,maximum:40}
  validates :email, presence: true, length:{minimum:3,maximum:40}
  validates :model, presence: true, length:{minimum:3,maximum:40}
  validates :year, presence: true, length:{minimum:3,maximum:4}
  
  belongs_to :car
  
  
 
  
  def self.to_csv
    CSV.generate do |csv|
      csv << column_names
      all.each do |appuser|
        csv <<  appuser.attributes.values_at(*column_names)
      end
    end
  end
   default_scope -> {order(model: :asc)}
end
