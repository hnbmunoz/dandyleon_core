class User < ApplicationRecord
  has_one :account
  has_many :transactions
  validates :fname, presence: true
  validates :email, presence: true, uniqueness: true
end
