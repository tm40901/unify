class InspectionResultsController < ApplicationController
  before_action :set_instrument, only: [:index, :new, :create]

  def index
    @inspection_results = @instrument.inspection_results.includes(:instrument).group_by(&:custom_id)
  end

  def new
    @inspection_result = InspectionResult.new
  end

  def create
    results_params = inspection_result_params[:results]
    custom_id = generate_custom_id

    results_params.each do |inspection_item_id, result|
      InspectionResult.create(
        instrument_id: @instrument.id,
        inspection_item_id: inspection_item_id,
        inspector_id: current_user.id,
        result: result == "1" ? "Pass" : "Fail",
        custom_id: custom_id,
        status: "pending"
      )
    end
    redirect_to instrument_path(@instrument.id), notice: '点検結果が保存されました。'
  end

  def show
    @inspection_results = InspectionResult.where(custom_id: params[:id])
  end


  def approve
    inspection_results = InspectionResult.where(custom_id: params[:id])
  
    # ステータスをapprovedに更新
    inspection_results.update_all(status: "approved")
  
    # 最初のInspectionResultのinstrumentの最終点検日を更新
    inspection_results.first.instrument.update(last_inspected_at: Time.now)
  
    redirect_to instrument_path(inspection_results.first.instrument_id), notice: '点検結果が承認されました。'
  end


  private
  def set_instrument
    @instrument = Instrument.find(params[:instrument_id])
    @inspection_items = @instrument.inspection_items
  end

  def generate_custom_id
    Time.now.strftime("%Y%m%d%H%M%S%L")
  end

  def inspection_result_params
    params.require(:inspection_result).permit(results: {})
  end
end
