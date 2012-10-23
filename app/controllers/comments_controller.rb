class CommentsController < ApplicationController

  before_filter :signed_in_user, only: [:create, :destroy, :edit, :update]
  before_filter :correct_user, only: [:destroy, :edit]

  def create
    @note = Note.find(params[:note_id])
    @comment = @note.comments.build(params[:comment].merge(user: current_user))
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
    @comment = Comment.find(params[:id])
    @note = @comment.note
    @comment.destroy
    redirect_to @note 
  end

  private

  def correct_user
    @comment = current_user.comments.find_by_id(params[:id])
    redirect_to root_path if @comment.nil?
  end
    

end
