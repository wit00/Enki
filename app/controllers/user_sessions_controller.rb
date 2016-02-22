class UserSessionsController < ApplicationController
  def destroy 
      sign_out
      redirect_to root_url
  end
  def create 
    user = User.find_by(name: params[:user_session][:name].downcase)
    if user
        # log in and go to learning page
        log_in user
        render 'static/home'
    else
      flash[:danger] = "Sorry, we do not have a user with that name and e-mail."
      redirect_to :back
    end
  end
end