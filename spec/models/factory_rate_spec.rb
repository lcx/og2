require 'rails_helper'

RSpec.describe FactoryRate, type: :model do
  describe 'Validations' do
    it { is_expected.to validate_presence_of(:kind) }
    it { is_expected.to validate_presence_of(:level) }
    it { is_expected.to validate_presence_of(:production) }
    it { is_expected.to validate_presence_of(:upgrade_duration) }

    context 'when creating multiple rates for the same kind' do
      let!(:factory_rate) { create(:factory_rate) }
      let(:second_rate) { build(:factory_rate, production: 20) }

      it 'is not valid to have two rates for the same kind and level' do
        expect(second_rate).not_to be_valid
      end
    end
  end
end
