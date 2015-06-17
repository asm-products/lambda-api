require 'rails_helper'

describe Devise::Models::JwtAuthenticatable do
  let(:model) { User }
  let(:factory) { model.to_s.downcase }
  let(:secret) { 'secret' }
  let(:exp) { 1.month.from_now }

  let(:claim) do
    { resource_id: resource.id, exp: exp.to_i }
  end

  let(:resource) { create factory }

  before do
    Timecop.freeze(Time.now)
    allow(Rails.application.secrets).to receive(:secret_key_base).and_return(secret)
  end

  after { Timecop.return }

  describe '#new_jwt' do
    subject { resource }
    let(:token) { make_token(claim, secret) }
    its(:new_jwt) { is_expected.to eq(token) }
  end

  describe '.from_jwt' do
    subject { model.from_jwt(token) }

    context 'valid token' do
      let(:token) { make_token(claim, secret) }
      it { is_expected.to eq(resource) }
    end

    context 'expired token' do
      let(:token) { make_token(claim.update(exp: Time.now.to_i - 100), secret) }
      it { is_expected.to be_nil }
    end

    context 'tampered token' do
      let!(:other) { create factory }
      let(:token) do
        new_claim = claim.dup.update(resource_id: other.id)
        new_claim_encoded = make_token(new_claim, secret).split('.')[1]

        orig_token = make_token(claim, secret).split('.')
        orig_token[1] = new_claim_encoded
        orig_token.join('.')
      end

      it { is_expected.to be_nil }
    end
  end

  def make_token(claim, secret)
    JSON::JWT.new(claim).sign(secret).to_s
  end
end
