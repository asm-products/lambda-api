class EmailSubscription
  class_attribute :mailchimp

  # Use MockMailchimp unless configured otherwise:
  # EmailSubscription.mailchimp = Mailchimp::API.new <API key>
  self.mailchimp = MockMailchimp::API.new

  def subscribe_launch(email)
    Rails.logger.debug "Subscribing #{email}"
    list_id = ENV['mailchimp_launch_subscription_list_id']
    mailchimp.lists.subscribe(list_id, email: email)
  end
end
