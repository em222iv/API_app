class Api::TagController < ApplicationController
  protect_from_forgery with: :null_session
  skip_before_filter :verify_authenticity_token
  before_action :api_auth
  respond_to :json, :xml

  def index
    @tag = Tag.all
    respond_with @tag
  end
  def show
    tag_event = Tag.find(params[:id])
    respond_with tag_event.events
  end
  def new
    @tag = Tag.new
  end
  #{"tag":{"tag":"taggiiie"}}
  def create
    @tag =  Tag.new(tag_params)
    if @tag.save
      respond_with @tag
    end
  end
  #{"tag":{"tag":"tag2"}}
  def update
    @tag = Tag.find(params[:id])
    if @tag.update_attributes(tag_params)
      respond_with @tag
    end
  end
  # render status: :too_many_requests # 424
  #  render status: :unprocessable_entity # 422
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
  private
  def tag_params
    params.require(:tag).permit(:tag)
  end
end
