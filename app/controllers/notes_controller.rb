class NotesController < BaseController
	# Not sure if we need this line but comment controller has it:
  load_and_authorize_resource

  def index
  	@notes = Note.all
  end

  def edit
  	@note = Note.find(params[:id])
  end

  def show
  	@note = Note.find(params[:id])
  end

# Comment update route:
  # def update
  #   @comment.uses_markdown = params[:comment].has_key? "uses_markdown"
  #   if CommentService.update(comment: @comment,
  #                            params: permitted_params.comment,
  #                            actor: current_user)
  #     redirect_to discussion_path(@comment.discussion, anchor: "comment-#{@comment.id}")
  #   else
  #     render :edit
  #   end
  # end

# Not sure about update:
  # def update
  # 	@note.uses_markdown = params[:note].has_key? "uses_markdown"
  # end

  def new
	@note = Note.new(note_params)
  end

  def destroy
	@note = Note.find(params[:id])
	@note.destroy
  end

private
  def note_params
	params.require(:note).permit(:commenter, :body)
	# Don't need line above but maybe something like it
  end

end

