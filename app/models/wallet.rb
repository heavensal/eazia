class Wallet < ApplicationRecord
  belongs_to :user

  def wallet_empty?
    self.tokens.zero?
  end
end
