class PostsController < ApplicationController

  def index
    @page = Page.friendly.find('news')
    @news = PostType.friendly.find('news').posts.published.page params[:page]
    @press = PostType.friendly.find('press').posts.published.page params[:page]
  end

  def show
  end

end
