class SessionsController < ApplicationController
  skip_before_action :user_check, :except => [:destroy]

  def index
    @user = User.new
    @user.build_profile
  end

  def new

  end

  def create
    @user = User.find_by_email(params[:email])
    if @user && @user.authenticate(params[:password])
      if params[:remember_me] # <<<<<<<
        permanent_sign_in(@user)
        redirect_to user_path(@user)
      else
        sign_in(@user)
        redirect_to user_path(@user)
      end
      #flash[:success] = "You've successfully signed in"
      #redirect_to root_url
    else
      flash[:error] = ""
      redirect_to root_url
    end
  end


  def destroy
    # another simple helper
    sign_out
    flash[:success] = "You've successfully signed out"
    redirect_to root_url
  end

end
