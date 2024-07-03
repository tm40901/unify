class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :move_to_index, except: [:index]

  def index
    if current_user.role == "管理者"
      @instruments = Instrument.where(admin_id: current_user.id)
    elsif current_user.role == "点検者"
      @instruments = Instrument.where(inspector_id: current_user.id)
    end
  end

  def show
    @inspection_results = InspectionResult.where(status: 'Pending', approver_id: current_user.id)
    @inspection_results = @inspection_results.group_by(&:custom_id)
    @count = @inspection_results.count
  end

  private
  def move_to_index
    unless current_user.role == "管理者"
      redirect_to action: :index
    end
  end
end
