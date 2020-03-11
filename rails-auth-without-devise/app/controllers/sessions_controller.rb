class SessionsController < ApplicationController
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
