class UsersController < ApplicationController
  before_action :authenticate_user!

  def show
    @inspection_results = current_user.inspector_inspection_results.where(status: 'Pending', approver_id: current_user.id)
    @inspection_results = @inspection_results.group_by(&:custom_id)
    @count = @inspection_results.count
  end
end
