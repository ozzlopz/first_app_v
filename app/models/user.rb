class User < ActiveRecord::Base
  has_many :offers
  
  before_save{self.email = email.downcase}
  validates :username, presence: true, length:{minimum:3,maximum:40}
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence:true, length:{maximum:105},
                                   uniqueness:{case_sensitive:false},
                                   format:{with: VALID_EMAIL_REGEX}
                                   
  validates :password, :confirmation => true,
                       :length => {:within => 6..40},
                       :allow_blank => true,
                       :on => :update 
  
  validates :password_confirmation, presence: true,
                                    :allow_blank => true,
                                    :on => :update 
  
  mount_uploader :picture, PictureUploader
  validate :picture_size
  
  private
    def picture_size
      if picture.size > 0.25.megabytes
        errors.add(:picture, "Debe pesar menos de 256KB")
      end
    end                                 
                                   
  has_secure_password
end
