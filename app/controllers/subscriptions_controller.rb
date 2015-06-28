class SubscriptionsController < ApplicationController
  def create
    email = params[:email]
    errors = []

    errors << 'Email is required' unless email.present?
    errors << 'Email is not valid' unless EmailValidator.valid? email

    respond_to do |format|
      if errors.any?
        format.json { render json: {errors: errors}, status:
                             :unprocessable_entity }
      else
        EmailSubscription.new.subscribe_launch(email)
        format.json { render json: {email:  email} }
      end
    end
  end
end
