class Admin::DashboardController < Admin::BaseController
  layout 'admin/layouts/application'
  def show
    @order_cares = OrderCare.order('id desc').paginate(:page => params[:page], :per_page => 20)
  end
end
