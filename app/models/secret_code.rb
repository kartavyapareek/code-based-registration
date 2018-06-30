class SecretCode < ApplicationRecord
  belongs_to :user, optional: true
  before_validation :generate_code

  validates :code, presence: true

  private
  def generate_code
    self.code = UUID.generate
  end
end
