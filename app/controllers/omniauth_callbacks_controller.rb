class OmniauthCallbacksController < ApplicationController
  skip_before_action :verify_authenticity_token

  def google_oauth2
    omniauth_sign_in
  end

  def facebook_access_token
    omniauth_sign_in
  end

  def twitter_access_token
    omniauth_sign_in
  end

  def failure
    respond_to do |format|
      format.html { redirect_to new_user_registration_url }
      format.json { render :failure, status: 422 }
    end
  end

  private

  def omniauth_sign_in
    @user = User.from_omniauth(request.env['omniauth.auth'])

    if @user.persisted?
      respond_to do |format|
        format.html { sign_in_and_redirect @user, event: :authentication }
        format.json { sign_in @user, store: false }
      end
    else
      redirect_to new_user_registration_url
    end
  end
end
