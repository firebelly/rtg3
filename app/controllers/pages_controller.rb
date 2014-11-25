class PagesController < ApplicationController

  before_filter :get_page

  def give
    @body_class = 'reasons'
    @reasons = Reason.published.unfulfilled.order('post_date DESC')
  end

  def educational_programs
  end

  def get_involved
    @affiliates = ["partners", "sponsors"]
    @partnered_supporters = SupporterType.friendly.find('partners').supporters
    @sponsored_supporters = SupporterType.friendly.find('sponsors').supporters
  end

  def apply
  end

  def about_us
    @body_class = 'about_us'
  end

  def success_stories
    @body_class = 'success_stories'
    @successes = Reason.published.is_success.order('post_date DESC')
  end

  def home
    @body_id = 'homepage'
    @reasons = Reason.published.unfulfilled.promoted
    @affiliates = ["partners", "sponsors", "featured"]
    @partnered_supporters = SupporterType.friendly.find('partners').supporters
    @sponsored_supporters = SupporterType.friendly.find('sponsors').supporters
    @featured_supporters = SupporterType.friendly.find('featured').supporters
    if @reasons.count < 3
      @reasons = @reasons + Reason.published.unfulfilled.random(3 - @reasons.count)
    end
  end

  def show
  end

  private

  def get_page
    @page = Page.friendly.find(params[:id])
  end

end
