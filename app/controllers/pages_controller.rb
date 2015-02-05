class PagesController < ApplicationController

  before_filter :get_page

  def what_we_do
  end

  def get_involved
    if stale?(etag: [@page, Supporter.maximum(:updated_at)])
      @affiliates = ["partners", "sponsors"]
      @partnered_supporters = SupporterType.friendly.find('partners').supporters
      @sponsored_supporters = SupporterType.friendly.find('sponsors').supporters
    end
  end

  def apply
  end

  def about_us
  end

  def supporters
    if stale?(etag: [@page, Supporter.maximum(:updated_at)])
      @body_class = "supporters-page"
      @sponsored_supporters = SupporterType.friendly.find('sponsors').supporters
      @partnered_supporters = SupporterType.friendly.find('partners').supporters
      @featured_supporters = SupporterType.friendly.find('featured').supporters
    end
  end

  def success_stories
    @body_class = 'success_stories'
    @successes = Reason.published.is_success.order('post_date DESC')
  end

  def home
    if stale?(etag: [@page, Reason.published.promoted.maximum(:updated_at)])
      @body_class = 'home'
      @reasons = Reason.published.promoted
      @affiliates = ["partners", "sponsors", "featured"]
      @partnered_supporters = SupporterType.friendly.find('partners').supporters
      @sponsored_supporters = SupporterType.friendly.find('sponsors').supporters
      @featured_supporters = SupporterType.friendly.find('featured').supporters
    end
  end

  def show
  end

  private

  def get_page
    @page = Page.friendly.find(params[:id])
    @og_image = view_context.image_url(@page.image) unless @page.image.blank?
    @og_description = @page.description unless @page.description.blank?
  end

end
