class User < ActiveRecord::Base
  attr_accessible :email, :name, :password

  validates :name, :email, :password, presence: true
  validates :email, uniqueness: true
  validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i }, :allow_blank => true, :allow_nil => true
  
end
