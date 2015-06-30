class SubscriptionsController < ApplicationController
  def create
    respond_to do |format|
      if errors.empty?
        EmailSubscription.new.subscribe_launch(params[:email])
        format.html { redirect_to root_path }
        format.json
      else
        format.html { redirect_to root_path }
        format.json { render json: { errors: errors }, status: :unprocessable_entity }
      end
    end
  end

  private

  def errors
    email = params[:email]
    errors = []

    errors << 'Email is required.' unless email.present?
    errors << 'Email is not valid.' unless EmailValidator.valid? email
    errors
  end
end
