class SessionsController < ApplicationController
  allow_unauthenticated_access only: %i[ new create google failure ]
  rate_limit to: 10, within: 3.minutes, only: :create, with: -> { redirect_to new_session_url, alert: "Try again later." }

  def new
  end

  def create
    if user = User.authenticate_by(params.permit(:email_address, :password))
      start_new_session_for user
      redirect_to after_authentication_url
    else
      redirect_to new_session_path, alert: "Try another email address or password."
    end
  end

  def destroy
    terminate_session
    redirect_to new_session_path
  end

  def google
    user = User.authenticate_by_omniauth(request.env["omniauth.auth"])
    start_new_session_for user
    redirect_to after_authentication_url, notice: "ログインに成功しました。"
  end

  def failure
    message = params[:message].presence || "authentication_failed"
    redirect_to new_session_path, alert: "Googleログインに失敗しました（#{message}）"
  end
end
