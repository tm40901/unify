class InstrumentsController < ApplicationController
  before_action :authenticate_user!
  before_action :move_to_index, except: [:index, :show]

  def index
    @instruments = Instrument.includes(:admin, :inspector).order("created_at DESC")
  end

  def new
    @instrument = Instrument.new
  end

  def create
    @instrument = Instrument.new(instrument_params)

    employee_number = params[:inspector_employee_number_field]
    inspector = User.find_by(employee_number: employee_number)
    if inspector
      @instrument.inspector_id = inspector.id
    end

    if @instrument.save
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @instrument = Instrument.find(params[:id])
    @inspection_item = InspectionItem.new
  end

  def load_inspectors
    @inspectors = User.select(:id, :employee_number, :last_name, :first_name, :department).where(role: "点検者")

    respond_to do |format|
      format.json { 
        render json: { inspectors: @inspectors, current_user_id: current_user.id }
      }
    end
  end

  private
  def move_to_index
    unless current_user.role == "管理者"
      redirect_to action: :index
    end
  end

  def instrument_params
    params.require(:instrument).permit(:management_number, :name, :manufacturer, :model, :serial_number).merge(admin_id: current_user.id)
  end
end
