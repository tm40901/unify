class InspectionResultsController < ApplicationController
  before_action :set_instrument, only: [:new, :create, :index]

  def new
    @inspection_result =  @instrument.inspection_results.new
    @inspection_items = @instrument.inspection_items
  end

  def create
    @inspection_result = @instrument.inspection_results.new(inspection_result_params)
    if @inspection_result.save
      redirect_to instrument_inspection_results_path(@instrument), notice: '点検結果が保存されました。'
    else
      flash.now[:alert] = '点検結果の保存に失敗しました。'
      render :new
    end
  end

  private
  def set_instrument
    @instrument = Instrument.find(params[:instrument_id])
  end

  def inspection_result_params
    params.require(:inspection_result).permit(:result)
  end
end
