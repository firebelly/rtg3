class PostsController < ApplicationController

  def index
    @page = Page.friendly.find('news')
    @news = PostType.friendly.find('news').posts.published
    @press = PostType.friendly.find('press').posts.published
  end

  def show
  end

end
