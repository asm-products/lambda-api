require 'rails_helper'

describe EmailSubscription do
  subject { EmailSubscription.new }
  let(:api) { instance_double('Mailchimp::API') }
  let(:lists) { instance_double('Mailchimp::Lists') }
  let(:list_id) { SecureRandom.hex(5) }
  let(:email) { Faker::Internet.email }

  before do
    allow(api).to receive(:lists).and_return(lists)
  end

  it 'defaults to the mocked mailchimp api' do
    expect(described_class.new.mailchimp).to be_a_kind_of MockMailchimp::API
  end

  describe '#subcribe_launch' do
    before do
      described_class.mailchimp = api
      ENV['mailchimp_launch_subscription_list_id'] = list_id
    end
    it 'subscribes to Mailchimp' do
      expect(lists).to receive(:subscribe).with list_id, email: email
      subject.subscribe_launch email
    end
  end
end
