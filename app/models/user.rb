class User < ActiveRecord::Base
  has_many :api_keys

  before_create :ensure_to_have_at_least_one_api_key

  def self.create_with_omniauth(auth)
    create! do |user|
      user.provider = auth['provider']
      user.uid = auth['uid']
      user.name = auth['info']['nickname']
      user.oauth_token = auth['credentials']['token']
    end
  end

  private

  def ensure_to_have_at_least_one_api_key
    api_keys.build if api_keys.blank?
  end
end
