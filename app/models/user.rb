class User < ApplicationRecord
  include ValidationPatterns
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :rides

  enum role: {
    customer: 0,
    admin: 1
  }
  validates :name, presence: true
  validates :phone, presence: true, uniqueness: true, format: { with: PHONE_REGEX, message: PHONE_REGEX_MESSAGE }
  validates :email, presence: true, uniqueness: true, format: { with: EMAIL_REGEX, message: EMAIL_REGEX_MESSAGE }
end
