class ApiKey < ActiveRecord::Base
  belongs_to :user

  scope :active, -> { where(active: true) }
  scope :valid, -> { where("? < expires_at", Time.now) }

  before_create :generate_access_token
  before_create :set_expiration
  before_create :set_active

  def before_expired?
    DateTime.now < self.expires_at
  end

  def set_active
    self.active = true
  end

  def expire!
    self.update! active: false
  end

  def set_expiration
    self.expires_at = Time.now.years_since(50)
  end

  private

  def generate_access_token
    self.access_token = SecureRandom.hex
  end
end
