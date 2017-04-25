class Stock < ApplicationRecord
  belongs_to :user

  validate :check_funds

  def check_funds
    if user.bank - (price * shares) < 0
      errors.add(:shares, "Insufficient funds!")
    end
  end
end
