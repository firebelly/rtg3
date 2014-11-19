class PagesController < ApplicationController

  before_filter :get_defaults

  def give
    @body_class = 'reasons'
    @reasons = Reason.published.unfulfilled.order('post_date DESC')
  end

  def educational_programs
  end

  def get_involved
  end

  def apply
  end

  def success_stories
    @body_class = 'success_stories'
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
  end

  private

  def get_defaults
    @page = Page.friendly.find(params[:id])
    @body_class = "#{request.path.gsub(/\/?([^\/]+)(.*)/,'\\1')}"
    @sidebar_promotion = Page.friendly.find('sidebar-promotion')
  rescue ActiveRecord::RecordNotFound => e
    @sidebar_promotion = nil
  end

end
