require 'rails_helper'

RSpec.describe Factory, type: :model do
  describe 'Associations' do
    it { is_expected.to belong_to(:player) }
  end
end
