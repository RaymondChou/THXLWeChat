class Admin::ActivitiesController < Admin::BaseController
  layout 'admin/layouts/application'

  def index
    news = Page.find_by_event('youhui')
    if news.present?
      @news = news
    else
      @news = Page.new(:event => 'youhui')
    end
  end

end
