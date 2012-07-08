class PagesController < ApplicationController
  def home
    if signed_in?
      @note  = current_user.notes.build
      @feed_items = current_user.feed.paginate(page: params[:page])
    end
  end

  def contact
  end

  def about
  end
end
