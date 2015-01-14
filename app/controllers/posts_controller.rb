class PostsController < ApplicationController

  before_filter :get_page, only: :index

  def index
    @news = PostType.friendly.find('news').posts.published.page params[:page]
    @press = PostType.friendly.find('press').posts.published.page params[:page]
  end

  def show
    @post = Post.friendly.find(params[:id])
  end

  private

  def get_page
  	@page = Page.friendly.find('news')
    @og_image = view_context.image_url(@page.image) unless @page.image.blank?
    @og_description = @page.description unless @page.description.blank?
  end

end
