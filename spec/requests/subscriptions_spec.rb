require 'rails_helper'

describe 'Subscriptions', type: :request do
  describe 'POST /subscriptions' do
    let(:service) { EmailSubscription.new }
    before { allow(EmailSubscription).to receive(:new).and_return(service) }
    it 'subscribes the user' do
      expect(service).to receive(:subscribe_launch).and_call_original
      post_json '/subscriptions', email: 'test@test.dev'
    end

    it 'redirect to root for html format' do
      expect(service).to receive(:subscribe_launch).and_call_original
      post '/subscriptions', email: 'test@test.dev'
      expect(response).to redirect_to(root_path)
    end

    describe 'errors' do
      it 'requires the email param' do
        post_json '/subscriptions'
        expect(response).to have_http_status(:unprocessable_entity)
        expect(JSON.parse(response.body)['errors']).to include(/Email is required/)
      end

      it 'validates the email param' do
        post_json '/subscriptions', email: 'invalid'
        expect(response).to have_http_status(:unprocessable_entity)
        expect(JSON.parse(response.body)['errors']).to include(/Email is not valid/)
      end

    end
  end
end
