class SessionsController < ApplicationController

  def new
  end

  def create
    user = User.find_by(email: params[:sessions][:email])

    if user && user.authenticate(params[:sessions][:password])
      session[:user_id] = user.id
      flash.now[:success] = "Welcome Home #{user.name}!"
      redirect_to links_path
    else
      flash.now[:error] = "Sorry wrong information!"
      render :new
    end
  end

end
