class Admin::TuansController < Admin::BaseController
  layout 'admin/layouts/application'

  def index
    news = Page.find_by_event('tuan')
    if news.present?
      @news = news
    else
      @news = Page.new(:event => 'tuan')
    end
  end

end
