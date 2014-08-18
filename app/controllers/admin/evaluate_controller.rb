class Admin::EvaluateController < Admin::BaseController
  layout 'admin/layouts/application'

  def index
    @evaluates = Evaluate.order('id desc').paginate(:page => params[:page], :per_page => 20)
  end
end
