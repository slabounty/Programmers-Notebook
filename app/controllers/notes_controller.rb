class NotesController < ApplicationController
  before_filter :signed_in_user, only: [:create, :destroy]
  before_filter :correct_user, only: :destroy

  def create
    @note = current_user.notes.build(params[:note])
    if @note.save
      flash[:success] = "Note created!"
      redirect_to root_path
    else
      @feed_items = []
      render 'pages/home'
    end
  end

  def destroy
    @note.destroy
    redirect_to root_path
  end

  private

    def correct_user
      @note = current_user.notes.find_by_id(params[:id])
      redirect_to root_path if @note.nil?
    end
    
end
