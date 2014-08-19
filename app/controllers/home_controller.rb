class HomeController < ApplicationController

  def index
    @ads = Ad.order('sort asc').all
  end

  def page
    page = Page.find_by_event(params[:id])
    if page.present? and page.url.present?
      redirect_to page.url
    else
      redirect_to '/'
    end
  end

end
