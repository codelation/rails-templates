class OmniAuthProvider < ActiveRecord::Base
  belongs_to :subscriber, polymorphic: true

  validates_presence_of :name, :subscriber_id

  def access_token
    @access_token ||= begin
      if self.auth_data && credentials = self.auth_data["credentials"]
        credentials["token"]
      end
    end
  end

  def access_token=(token)
    self.auth_data = { credentials: { token: token } }
    @access_token = token
  end
end
