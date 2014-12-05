class AdminController < ApplicationController
  #skip_before_filter :authorize, only: [:index]
  def index
    @overdues = Payment.get_overdue_list
    @payments = Payment.where(collected_on: Time.now.to_date)
    respond_to do |format|
      format.html # overdues.html.erb
      format.json { render json: @overdues }
    end
  end
end
