class SessionsController < ApplicationController

  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      log_in user
      flash[:success] = "You have successfully logged in!"
      redirect_back_or user
    else
      flash.now[:danger] = 'Invalid email/password combination'
      render 'new'
    end
  end

  def destroy
    log_out
    redirect_to login_url
  end

  ## This is called from a client who wish to authenticate and get a JSON Web Token back
  def api_auth
    # output the APIkey from the header
    # puts request.headers["X-APIkey"];
    creator = Creator.find_by(creator: request.headers[:creator])
    if creator && creator.authenticate(request.headers[:password])
      render json: { auth_token: encodeJWT(creator), id: creator.id}
    else
      render json: { error: 'Invalid username or password' }, status: :unauthorized
    end
  end
end