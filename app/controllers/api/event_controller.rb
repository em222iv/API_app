class Api::EventController < ApplicationController
  protect_from_forgery with: :null_session
  skip_before_filter :verify_authenticity_token
  before_action :api_auth
  before_action :offset_params, only: [:index, :nearby]
  respond_to :json, :xml

  #http://localhost:3000/api/event.json?limit=10&offset=0
  def index
    @event = Event.all.order(created_at: :desc)
   if offset_params.present?
     @event = Event.limit(@limit).offset(@offset).order(created_at: :desc)
   end
    respond_with @event
  end
  def show
    respond_with Event.find(params[:id])
  end
  def new
    @event = Event.new
  end
  #     find_all(*args).first || raise(MissingTemplate.new(self, *args)) = byt parametrar i postman
  # {"event":{"tagID":2,"positionID":"2"}}

  #create with tag
  #{ "event": { "tagID": "8", "positionID": "8"}, "tag": { "tag": "coole"}}
  def create
    @event =  Event.new(event_params)
    @tag = Tag.new(tag_params)
    @creator = Creator.new(creator_params)

    if Tag.find_by_tag(@tag.tag).present?
      @tag = Tag.find_by_tag(@tag.tag)
    end
    if Tag.find_by_tag(@creator.creator).present?
      @tag = Tag.find_by_tag(@creator.creator)
    end
    @event.tags << @tag

    if @event.save && @tag.save && creator.save
      respond_with @event
    end
  end
  #
  #{"id":3,"tagID":3,"positionID":3,"created_at":"2015-02-18T12:48:19.772Z","updated_at":"2015-02-18T12:57:20.138Z"}
  def update
    @event = Event.find(params[:id])
    if @event.update_attributes(event_params)
      respond_with @event
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
  # This method is using the geocoder and helps with searching near a specific position
  def nearby

    # Check the parameters
    if params[:long].present? && params[:lat].present?

      # using the parameters and offset/limit
      @position = Position.near([params[:lat].to_f, params[:long].to_f], 20).limit(@limit).offset(@offset)
      respond_with @position, status: :ok
    else
      error = ErrorMessage.new("Could not find any resources. Bad parameters?", "Could not find any team!" )
      render json: error, status: :bad_request # just json in this example
    end
  end

  private
  def event_params
    params.require(:event).permit(:positionID,:creatorID,:description)
  end
  def tag_params
    params.require(:tag).permit(:tag)
  end
  def creator_params
    params.require(:creator).permit(:creator)
  end
end
