class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session
  include SessionsHelper

  # default parameters, maby put i config-file?


  # check if user whants offset/limit
  def offset_params
    if params[:offset].present?
      @offset = params[:offset].to_i
    end
    if params[:limit].present?
      @limit = params[:limit].to_i
    end
  end


  def api_key
    api_key = request.headers['ClientKey']
    @decode = decodeJWT(api_key)
      if @decode
        @creator_id = @decode[0]['creator_id']
        @decode
      else
        render json: { error: 'The provided token wasn´t correct' }, status: :bad_request
      end
  end
end
