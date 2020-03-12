class SessionsController < ApplicationController

  def create_with_google_oauth
    omniauth_hash = request.env['omniauth.auth']
    @user = User.find_or_create_by(email: omniauth_hash['info']['email']) do |u|
      u.password = SecureRandom.hex
    end
    if @user.persisted?
      session[:user_id] = @user.id
      redirect_to user_path(@user)
    else
      render :new
    end
  end

  def create
    @user = User.find_by(email: params[:email])
    if @user && @user.authenticate(params[:password])
      # success
      session[:user_id] = @user.id
      redirect_to user_path(@user)
    else
      render :new
    end

  end

  def destroy
    reset_session
    redirect_to '/'
  end
end
