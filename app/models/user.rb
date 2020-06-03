class User < ApplicationRecord
  has_secure_token

  has_many :stuffs
end
