require 'rails_helper'
RSpec.describe 'Sign In', type: :system do
  let!(:player) { create :player }

  context 'when signing in player' do
    context 'when sign in is successful' do
      before { login(email: player.email) }

      it 'redirects to home' do
        expect(page).to have_content 'Signed in successfully.'
      end
    end

    context 'when sign in failed' do
      before { login(email: player.email, password: '1234') }

      it 'show errors' do
        expect(page).to have_content 'Invalid Email or password.'
      end
    end
  end
end
