class UsersController < ApplicationController
  before_action :authenticate_user!
  
  def index
    if current_user.role == "管理者"
      @instruments = Instrument.where(admin_id: current_user.id)
    elsif current_user.role == "点検者"
      @instruments = Instrument.where(inspector_id: current_user.id)
    end
  end

  def show
    @inspection_results = current_user.inspector_inspection_results.where(status: 'Pending', approver_id: current_user.id)
    @inspection_results = @inspection_results.group_by(&:custom_id)
    @count = @inspection_results.count
  end
end
