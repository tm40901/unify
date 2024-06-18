class InspectionItemsController < ApplicationController
  before_action :set_instrument

  def create
    @inspection_item = @instrument.inspection_items.new(inspection_item_params)

    if @inspection_item.save
      redirect_to instrument_path(@instrument.id), notice: "点検項目が追加されました。"
    else
      flash.now[:alert] = "点検項目を入力してください。"

      render "instruments/show", status: :unprocessable_entity
    end
  end

  private
  def set_instrument
    @instrument = Instrument.find(params[:instrument_id])
  end

  def inspection_item_params
    params.require(:inspection_item).permit(:item)
  end
end