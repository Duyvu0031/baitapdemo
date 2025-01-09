class User < ApplicationRecord
  has_secure_password
  has_many :sessions, dependent: :destroy
  validates :password, length: { minimum: 6, message: "Mật khẩu phải có ít nhất 6 ký tự" }, if: :password_required?
  validates :password_confirmation, presence: true, if: :password_required?
  validate :passwords_match, if: :password_required?
  

  def password_required?
    new_record? || password.present?
  end
  # Kiểm tra mật khẩu xác nhận có khớp không
  def passwords_match
    if password != password_confirmation
      errors.add(:password_confirmation, "Mật khẩu không khớp 😞")
    end
  end

  normalizes :email_address, with: ->(e) { e.strip.downcase }
  def self.authenticate_by(email_address:, password:)
    user = find_by(email_address: email_address)
    user&.authenticate(password) # `authenticate` sẽ so khớp mật khẩu nếu có
  end
end
