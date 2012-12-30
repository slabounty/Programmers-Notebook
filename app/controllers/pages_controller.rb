class PagesController < ApplicationController
  def home
    if signed_in?
      @note  = current_user.notes.build
      @feed_items = current_user.feed(true, params[:tag]).paginate(page: params[:page])
    end
  end

  def feed
    if signed_in?
      @note  = current_user.notes.build
      @feed_items = current_user.feed(false, params[:tag]).paginate(page: params[:page])
    end
  end

  def contact
  end

  def about
  end
end
