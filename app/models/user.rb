class User < ApplicationRecord
  has_many :reviews

  validates_presence_of :username
end
