class Admin::OrderDriveController < Admin::BaseController
  layout 'admin/layouts/application'

  def index
    @order_drives = OrderDrive.order('id desc').paginate(:page => params[:page], :per_page => 20)
  end
end
