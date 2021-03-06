class User < ActiveRecord::Base
  has_many :api_keys

  scope :find_by_valid_token, -> (t) { joins(:api_keys).where(api_keys: { access_token: t, active: true }) }

  before_create :ensure_to_have_at_least_one_api_key

  def self.create_with_omniauth(auth)
    create! do |user|
      user.provider = auth['provider']
      user.uid = auth['uid']
      user.name = auth['info']['nickname']
      user.image_url = auth['info']['image']
      user.oauth_token = auth['credentials']['token']
    end
  end

  def self.find_and_update(auth)
    user = find_by(provider: auth['provider'], uid: auth['uid'])
    user&.update(
      name: auth['info']['nickname'],
      image_url: auth['info']['image']
    )

    user
  end

  def current_api_key
    api_keys.active.valid.last
  end

  def reset_api_key!
    self.class.transaction do
      current_api_key.expire!
      api_keys.create!
    end

    current_api_key
  end

  private

  def ensure_to_have_at_least_one_api_key
    api_keys.build if api_keys.blank?
  end
end
