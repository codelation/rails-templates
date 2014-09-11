class AdminUser < ActiveRecord::Base
  devise :database_authenticatable, :trackable
end
