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
    before do
      login(email: player.email)
    end

    context 'with iron factory' do
      let(:iron_factory) { player.iron_factory }

      before do
        iron_factory.update(level: 3, resources: 40)
        visit player_path(player)
      end

      it 'shows the iron factory, level and resources' do
        expect(page).to have_content 'Iron (Level: 3, Resources: 40)'
      end
    end

    context 'with copper factory' do
      let(:copper_factory) { player.copper_factory }

      before do
        copper_factory.update(level: 3, resources: 40)
        visit player_path(player)
      end

      it 'shows the copper factory, level and resources' do
        expect(page).to have_content 'Copper (Level: 3, Resources: 40)'
      end
    end

    context 'with gold factory' do
      let(:gold_factory) { player.gold_factory }

      before do
        gold_factory.update(level: 4, resources: 60)
        visit player_path(player)
      end

      it 'shows the gold factory, level and resources' do
        expect(page).to have_content 'Gold (Level: 4, Resources: 60)'
      end
    end
  end
end
