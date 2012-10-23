class CommentsController < ApplicationController
  def create
    @note = Note.find(params[:note_id])
    @comment = @note.comments.build(params[:comment])
    if @comment.save
      flash[:success] = "Comment created!"
      redirect_to @note
    else
      flash[:success] = "Could not create comment!"
      redirect_to @note
    end

  end

  def edit
    @comment = Comment.find(params[:id])
  end

  def update
    @comment = Comment.find(params[:id])
    if @comment.update_attributes(params[:comment])
        redirect_to root_path # Wrong path
    else
      render 'edit'
    end
  end

  def destroy
    @comment.destroy
    redirect_to root_path # Wrong path
  end

end
