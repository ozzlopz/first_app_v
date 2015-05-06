class Offer < ActiveRecord::Base

  belongs_to :user
  has_many :offer_cars
  has_many :cars, through: :offer_cars
  
  validates :user_id, presence: true
  
  validates :name, presence: true, length:{minimum: 5,maximum: 100}
  validates :summary, presence: true, length:{minimum:10,maximum:150}
  validates :description, presence: true, length:{minimum:20,maximum:500}

   default_scope -> {order(updated_at: :desc)}

  mount_uploader :picture, PictureUploader
  validate :picture_size
  
  private
    def picture_size
      if picture.size > 5.megabytes
        errors.add(:picture, "Debe pesar menos de 5MB")
      end
    end
end