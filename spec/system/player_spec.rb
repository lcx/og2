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
end
