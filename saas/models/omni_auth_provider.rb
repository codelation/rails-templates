class OmniAuthProvider < ActiveRecord::Base
  belongs_to :subscriber, polymorphic: true
end
