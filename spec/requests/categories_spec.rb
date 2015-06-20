require 'rails_helper'

describe 'Categories', type: :request do
  let!(:categories) { create_list :category, 5 }
  subject { response }

  let(:user) { create :user }
  before { sign_in user }

  describe 'GET /categories' do
    include_examples 'authentication required', :get, '/categories'

    before { get_json '/categories'  }
    let(:obj) { JSON.parse response.body }

    it { is_expected.to match_json_schema('categories/categories') }

    it 'returns all categories' do
      expect(obj.count).to eq(categories.count)
    end
  end
end
