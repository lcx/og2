require 'rails_helper'

RSpec.describe Player, type: :model do
  describe 'Associations' do
    it { is_expected.to have_many(:factories).dependent(:destroy) }
  end

  describe 'New player' do
    let(:player) { create(:player) }

    it 'creates new player at level 1' do
      expect(player.level).to eq(1)
    end

    it 'creates three factories per user' do
      expect(player.factories.count).to eq(3)
    end
  end

  describe 'Factories' do
    let(:player) { create(:player) }

    it 'fetches the iron factory' do
      expect(player.iron_factory.kind).to eq('iron')
    end

    it 'fetches the copper factory' do
      expect(player.copper_factory.kind).to eq('copper')
    end

    it 'fetches the gold factory' do
      expect(player.gold_factory.kind).to eq('gold')
    end
  end
end
