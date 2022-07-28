require 'rails_helper'

RSpec.describe Factory, type: :model do
  describe 'Associations' do
    it { is_expected.to belong_to(:player) }
  end

  describe 'Validations' do
    it { is_expected.to validate_presence_of(:kind) }
    it { is_expected.to validate_presence_of(:player_id) }
    it { is_expected.to validate_presence_of(:level) }
    it { is_expected.to validate_presence_of(:resource) }
  end

  describe '#factory_rate' do
    let!(:factory_rate) { create(:factory_rate) }
    let!(:factory) { create(:factory) }

    it 'returns factory rate for current level' do
      expect(factory.factory_rate).to eq(factory_rate)
    end
  end
end
