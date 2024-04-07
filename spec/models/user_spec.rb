require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { User.create(wallet: 10.0) } # Supposons que le wallet est initialisé à 10 à la création

  context 'when newly created' do
    it 'has a wallet balance of 10' do
      expect(user.wallet).to eq(10.0)
    end
  end

  context 'when purchasing' do
    it 'can consume the wallet down to 0' do
      user.wallet -= 10.0
      expect(user.wallet).to eq(0.0)
      expect(user.valid?).to be true
    end

    it 'cannot have a wallet balance below 0' do
      user.wallet -= 11.0
      expect(user.wallet).not_to be < 0
      expect(user.valid?).to be false
      expect(user.errors[:wallet]).to include('must be greater than or equal to 0') # Assure-toi que ceci correspond au message d'erreur réel
    end
  end
end
