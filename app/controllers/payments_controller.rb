class PaymentsController < ApplicationController
  # GET /payments
  # GET /payments.json
  def index
    @subscriber = Subscriber.find_by_id(params[:subscriber_id])
    if @subscriber
      @payments = Payment.paginate(:page  => params[:page], :per_page => 20).where(subscriber_id: @subscriber.id).order('id DESC')
      @list_name = "all payments for subscriber: #{@subscriber.id} (#{@subscriber.name})"
    else
      @payments = Payment.paginate(:page  => params[:page], :per_page => 20).order('id DESC')
      @list_name = "all payments"
    end
    
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @payments }
    end
  end

  # GET /payments/1
  # GET /payments/1.json
  def show
    @payment = Payment.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @payment }
    end
  end

  # GET /payments/new
  # GET /payments/new.json
  def new
    subscriber = Subscriber.find_by_id(params[:subscriber_id])
    @payment = Payment.new
   
    if subscriber
      @header_sfx = " for subscriber: #{subscriber.id} (#{subscriber.name})"
      @payment.subscriber_id = subscriber.id 
      @payment.amount = subscriber.subscription_amount
    end
    @payment.agent_id = current_user.id if current_user && current_user.has_role?(User::IS_AN_AGENT)
        
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @payment }
    end
  end

  # GET /payments/1/edit
  def edit
    @payment = Payment.find(params[:id])
  end

  # POST /payments
  # POST /payments.json
  def create
    @payment = Payment.new(params[:payment])

    respond_to do |format|
      if @payment.save
        format.html { redirect_to @payment, notice: 'Payment was successfully created.' }
        format.json { render json: @payment, status: :created, location: @payment }
      else
        format.html { render action: "new" }
        format.json { render json: @payment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /payments/1
  # PUT /payments/1.json
  def update
    @payment = Payment.find(params[:id])

    respond_to do |format|
      if @payment.update_attributes(params[:payment])
        format.html { redirect_to @payment, notice: 'Payment was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @payment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /payments/1
  # DELETE /payments/1.json
  def destroy
    @payment = Payment.find(params[:id])
    @payment.destroy

    respond_to do |format|
      format.html { redirect_to payments_url }
      format.json { head :no_content }
    end
  end
  
  def overdues
    @overdues = Payment.get_overdue_list
    respond_to do |format|
      format.html # overdues.html.erb
      format.json { render json: @overdues }
    end
  end
end
