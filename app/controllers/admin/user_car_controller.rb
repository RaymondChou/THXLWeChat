class Admin::UserCarController < Admin::BaseController
  layout 'admin/layouts/application'

  def index
    @user_cars = UserCars.order('id desc').paginate(:page => params[:page], :per_page => 20)
  end
end
