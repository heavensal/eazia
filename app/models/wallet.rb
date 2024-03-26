class Wallet < ApplicationRecord
  belongs_to :user

  after_create -> { add_tokens(10) }

  validates :tokens, presence: true, numericality: { greater_than_or_equal_to: 0 }

  def wallet_empty?
    self.tokens.zero?
  end

  def add_tokens(amount)
    self.update!(tokens: self.tokens + amount)
  end

  def remove_tokens(amount)
    self.update!(tokens: self.tokens - amount)
  end

  def enough_tokens?(amount)
    self.tokens >= amount
  end

  def tokens_for_freemium
    add_tokens(10)
  end

  def tokens_for_premium
    add_tokens(100)
  end

  def force_tokens(amount)
    self.update!(tokens: amount)
  end
end
