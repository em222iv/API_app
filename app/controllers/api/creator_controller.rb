class Api::CreatorController < ApplicationController
  protect_from_forgery with: :null_session
  skip_before_filter :verify_authenticity_token
  respond_to :json, :xml

  def index
    @creator = Creator.all
    respond_with @creator
  end
  def show
    creator = Tag.find(params[:id])
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
  private
  def creator_params
    params.require(:creator).permit(:creator)
  end
end
