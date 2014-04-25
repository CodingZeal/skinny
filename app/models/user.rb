class User < ActiveRecord::Base

  has_secure_password

  validates :firstname, presence: true, length: 2..50
  validates :middlename, length: 2..50, allow_blank: true
  validates :lastname, presence: true, length: 2..50
  validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i }
  validates :password, presence: true, confirmation: true, length: { minimum: 8 }

  def self.authenticate(email, password)
    if user = where(email: email)
      user.authenticate(password)
    else
      false
    end
  end

  def fullname
    @fullname ||= [self.firstname, self.middlename, self.lastname].compact.join(' ')
  end

  def permissions
    @permissions ||= []
  end
end