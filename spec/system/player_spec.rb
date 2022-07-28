require 'rails_helper'
RSpec.describe 'Player', type: :system do
  let!(:player) { create :player }

  context 'when player is not signed in' do
    before { visit player_path(player) }

    it 'requests log in' do
      expect(page).to have_content 'You need to sign in or sign up before continuing.'
    end

    it 'redirects to log in' do
      expect(page).to have_current_path '/players/sign_in'
    end
  end

  context 'when player checks profile' do
    let(:iron_factory) { player.iron_factory }
    let(:copper_factory) { player.copper_factory }
    let(:gold_factory) { player.gold_factory }

    before do
      iron_factory.update(level: 2, resources: 10)
      copper_factory.update(level: 3, resources: 40)
      gold_factory.update(level: 4, resources: 60)
      login(email: player.email)
      visit player_path(player)
    end

    context 'When players check profile should be able to see to the level of their factories' do
      it 'shows the iron factory, level and resources' do
        expect(page).to have_content 'Iron (Level: 2, Resources: 10)'
      end

      it 'shows the copper factory, level and resources' do
        expect(page).to have_content 'Copper (Level: 3, Resources: 40)'
      end

      it 'shows the gold factory, level and resources' do
        expect(page).to have_content 'Gold (Level: 4, Resources: 60)'
      end
    end
  end

  context 'when player connects they will see the list of every player and their resrouces' do
    let!(:player_susan) { create(:player, email: 'susan@example.com', level: 3) }
    let!(:player_john) { create(:player, email: 'john@example.com', level: 4) }

    before do
      player_susan.iron_factory.update(resources: 10)
      player_susan.copper_factory.update(resources: 20)
      player_susan.gold_factory.update(resources: 30)
      player_susan.reload

      player_john.iron_factory.update(resources: 30)
      player_john.copper_factory.update(resources: 10)
      player_john.gold_factory.update(resources: 0)
      player_john.reload
      login(email: player.email)
    end

    it 'shows susans level and resources' do
      expect(page).to have_content 'susan@example.com (Level: 3, Iron: 10, Copper: 20, Gold: 30)'
    end

    it 'shows john with level and resources' do
      expect(page).to have_content 'john@example.com (Level: 4, Iron: 30, Copper: 10, Gold: 0)'
    end
  end

  context 'when player checks production rate and upgrade' do
    let!(:iron_factory_rate) { create(:factory_rate) }
    let!(:iron_factory) { player.iron_factory }

    before do
      login(email: player.email)
      sleep 1
      visit player_path(player)
    end

    it 'show current production rate of iron' do
      expect(page).to have_content 'Iron production: 10/s'
    end

    it 'shows upgrade cost for factory' do
      expect(page).to have_content 'Iron upgrade requirements: 300 Iron, 100 Copper, 1 Gold,'
    end
  end
end
