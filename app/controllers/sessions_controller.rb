class SessionsController < ApplicationController
  def new
  end

  def create
  	user = User.find_by(email: params[:session][:email].downcase)
  	if user && user.authenticate(params[:session][:password])
  		# Log the user in and redirect to the user's show page
      log_in user
      params[:session][remember_me] == '1' ? remember(user) : forget(user)
      remember user
      redirect_to user
  	else
  		# Create an error page
      flash.now[:danger] = '아이디 혹은 비밀번호가 옳바르지 않습니다!!!'
  		render 'new'
  	end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end

end
