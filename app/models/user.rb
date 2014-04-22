class User < ActiveRecord::Base

  has_many :pages
  has_many :user_roles
  has_many :roles, through: :user_roles
  has_many :roles_permissions
  has_many :permissions, through: :roles_permissions

  has_secure_password

  validates :name, length: 2..50
  validates :name, presence: true
  validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i, on: :create }
  validates :password, presence: true
  validates :password, confirmation: true
  validates :password, strength: true
  validates :password, length: { minimum: 8 }

  def self.authenticate(email, password)
    if user = where(email: email)
      user.authenticate(password)
    else
      false
    end
  end
end