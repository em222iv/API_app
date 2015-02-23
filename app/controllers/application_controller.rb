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
end
