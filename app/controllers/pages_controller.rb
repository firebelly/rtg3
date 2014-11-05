class PagesController < ApplicationController

  before_filter :get_defaults

  def give
    @body_class = 'reasons'
    @page = Page.find('give')
    @reasons = Reason.published.unfulfilled.order('post_date DESC')
  end

  def for_sponsors
    @page = Page.find('for-sponsors')
  end

  def success_stories
    @body_class = 'success_stories'
    @page = Page.find('success-stories')
    @successes = Reason.published.is_success.order('post_date DESC')
  end

  def home
    @body_id = 'homepage'
    # @news_type = PostType.where(:slug => 'news').first
    # unless @news_type.nil?
    #     @news_posts = @news_type.posts.published.limit(2)
    # else
    #   @news_posts = []
    # end
    @reasons = Reason.published.unfulfilled.promoted
    if @reasons.count < 3
      @reasons = @reasons + Reason.published.unfulfilled.random(3 - @reasons.count)
    end
    # @successes = Reason.published.is_success.order('post_date DESC').limit(5)
  end

  def show
    # make sure page is not a child
    parent = Page.find(params[:id])
    child = (params[:child_id]) ? Page.find(params[:child_id]) : nil

    # make sure parent is actually a parent
    if (parent.parent)
      redirect_to page_path(parent.parent, parent)
      return
    end

    @page = child || parent
  end

  private

  def get_defaults
    @body_class = "#{request.path.gsub(/\/?([^\/]+)(.*)/,'\\1')}"
    @sidebar_promotion = Page.find('sidebar-promotion')
  rescue ActiveRecord::RecordNotFound => e
    @sidebar_promotion = nil
  end

end
