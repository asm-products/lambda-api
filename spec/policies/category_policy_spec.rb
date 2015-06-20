require 'rails_helper'

describe CategoryPolicy do
  let(:user) { User.new }

  subject { described_class }

  permissions :index? do
    it 'allows any user' do
      expect(subject).to permit(user)
    end
  end
end
