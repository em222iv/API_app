module SessionsHelper

  # Logs in the given user.
  def log_in(user)
    session[:user_id] = user.id
  end

  # Returns the current logged-in user (if any).
  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end
  # Returns true if the given user is the current user.
  def current_user?(user)
    user == current_user
  end
  # Returns true if the user is logged in, false otherwise.
  def logged_in?
    !current_user.nil?
  end
  # Logs out the current user.
  def log_out
    session.delete(:user_id)
    @current_user = nil
  end
  # Redirects to stored location (or to the default).
  def redirect_back_or(default)
    redirect_to(session[:forwarding_url] || default)
    session.delete(:forwarding_url)
  end

  # Stores the URL trying to be accessed.
  def store_location
    session[:forwarding_url] = request.url if request.get?
  end

  #check
  def api_auth
    if request.headers["Authorization"].present?
      key = request.headers["Authorization"]
      @user = User.where(key: key).first if key
      unless @user
        render status: :unauthorized # 401
        return false
      end
    end
  end



  # This method is for encoding the JWT before sending it out
  def encodeJWT(creator, exp=2.hours.from_now)
    # add the expire to the payload, as an integer
    payload = { creator_id: creator.id }
    payload[:exp] = exp.to_i

    # Encode the payload whit the application secret, and a more advanced hash method (creates header with JWT gem)
    JWT.encode( payload, Rails.application.secrets.secret_key_base, "HS512")

  end

  # When we get a call we have to decode it - Returns the payload if good otherwise false
  def decodeJWT(token)
    # puts token
    payload = JWT.decode(token, Rails.application.secrets.secret_key_base, "HS512")
    # puts payload
    if payload[0]["exp"] >= Time.now.to_i
      payload
    else
      puts "Timeout"
      false
    end
      # catch the error if token is wrong
  rescue => error
    puts error
    nil
  end

end