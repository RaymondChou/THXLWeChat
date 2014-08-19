class Admin::NewsController < Admin::BaseController
  layout 'admin/layouts/application'

  def index
    news = Page.find_by_event('news')
    if news.present?
      @news = news
    else
      @news = Page.new(:event => 'news')
    end
  end

end
