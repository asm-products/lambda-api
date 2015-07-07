if Rails.env.production?
  EmailSubscription.mailchimp = Mailchimp::API.new ENV['mailchimp_api_key']
end
