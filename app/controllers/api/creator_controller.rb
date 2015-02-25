class Api::CreatorController < ApplicationController
  protect_from_forgery with: :null_session
  skip_before_filter :verify_authenticity_token
  before_action :api_auth
  before_action :api_key
  respond_to :json, :xml

  def index
    @creator = Creator.all
    respond_with @creator
  end
  def show
    creator = Creator.find(params[:id])
    respond_with creator.events
  end
  def new
    @creator = Creator.new
  end
  #{"creator":{"creator":"Erik-san"}}
  def create
    @creator =  Creator.new(creator_params)
    if @creator.save
      respond_with @creator
    end
  end
  #{"creator":{"creator":"Creator2"}}
  def update
    @creator = Creator.find(params[:id])
    if @creator.update_attributes(creator_params)
      respond_with @creator
    end
  end
  # render status: :too_many_requests # 424
  #  render status: :unprocessable_entity # 422

  private
  def creator_params
    params.require(:creator).permit(:creator,:password)
  end
end
