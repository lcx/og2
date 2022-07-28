module TestingSupport
  module FeaturesHelpers
    def login(email:, password: 'password')
      visit new_player_session_path
      fill_in 'player_email', with: email
      fill_in 'player_password', with: password
      click_button('commit')
    end
  end
end

RSpec.configure do |config|
  config.include TestingSupport::FeaturesHelpers, type: :system
end
