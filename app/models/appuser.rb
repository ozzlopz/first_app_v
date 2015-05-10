class Appuser < ActiveRecord::Base
  attr_accessible :name, :first_last_name, :second_last_name, :lada, :phone, :email, :model, :serial_number
end
