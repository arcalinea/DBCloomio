class NotesController < GroupBaseController
	# Not sure if we need this line but comment controller has it:
  # load_and_authorize_resource
  before_filter :authenticate_user!, :except => [:show, :index]
  before_filter :load_resource_by_key, except: [:new, :create, :index, :update_version]

  def index
    @group = Group.find_by_key(params[:group_id])
  	@notes = Note.where(group_id: @group.id)
    # @notes = Note.where(group_id: params[:group_id])
    # p "*" * 90
    # p params[:group_id]
    # p "*" * 80

  end


  def edit
  	@note = Note.find(params[:id])
  end


  def show
    @group = @note.group
  	@note = Note.find(params[:id])
  end


  def new
	 @note = Note.new user: current_user
   @group = Group.find_by_id params[:group_id]

   @note.group = @group

   render :new
  end

  def create
    @note = Note.new(note_params)
    @note.user = current_user
    p @note.user
    p current_user

    if @note.save
      redirect_to @note
    else
      render action: :new
    end
  end

  def destroy
	@note = Note.find(params[:id])
	@note.destroy
  end

private
  def load_resource_by_key
    @note ||= Note.find(params[:id])
  end

  def note_params
	 params.require(:note).permit(:title, :description, :group_id, :user_id)
	# Don't need line above but maybe something like it
  end

end

