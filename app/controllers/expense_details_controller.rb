class ExpenseDetailsController < ApplicationController
  before_action :set_expense_detail, only: [:show, :edit, :update, :destroy]

  # GET /expense_details
  # GET /expense_details.json
  def index
    db_date_format = "%Y-%m-%d"

    if params[:from_date_picker].nil?
      session[:from_date_picker] ||= (Date.today - 7).strftime(db_date_format)
      session[:to_date_picker] ||= Date.today.strftime(db_date_format)

      params[:from_date_picker] = session[:from_date_picker]
      params[:to_date_picker] = session[:to_date_picker]
    end 
    
    session[:from_date_picker] = params[:from_date_picker]
    session[:to_date_picker] = params[:to_date_picker]
    
    @expense_details = ExpenseDetail.where(["today >= ? and today <= ?", params[:from_date_picker], params[:to_date_picker]]).order("today ASC")
    @expense_detail = ExpenseDetail.new
  end

  # GET /expense_details/1
  # GET /expense_details/1.json
  def show
    if params[:opt] == "copy"
      target_date = Date.today

      @expense_detail.CopyWholeDay(target_date)

      redirect_to action: :index 
    end  
  end

  # GET /expense_details/new
  def new
    @expense_detail = ExpenseDetail.new
  end

  def new_v2
    @expense_detail = ExpenseDetail.new
  end 

  # GET /expense_details/1/edit
  def edit
    respond_to do |format|
      format.html
      format.js
    end 
  end

  # POST /expense_details
  # POST /expense_details.json
  def create
    if params[:commit].casecmp("go") == 0 
      @expense_detail = ExpenseDetail.new(expense_detail_params)

      respond_to do |format|
        if @expense_detail.save
          format.html { redirect_to expense_details_path, notice: 'Expense detail was successfully created.' }
          format.json { render action: 'show', status: :created, location: @expense_detail }
          format.js
        else
          format.html { render action: 'new_v2' }
          format.json { render json: @expense_detail.errors, status: :unprocessable_entity }
        end
      end    
    elsif params[:commit] == "cancel"
      @expense_detail = ExpenseDetail.new

      respond_to do |format|
        format.js { render "cancel" }
      end
    end
  end

  # PATCH/PUT /expense_details/1
  # PATCH/PUT /expense_details/1.json
  def update
    if params[:commit] == "go"
      respond_to do |format|
        if @expense_detail.update(expense_detail_params)
          format.html { redirect_to expense_details_path, notice: 'Expense detail was successfully updated.' }
          format.json { head :no_content }
          format.js
        else
          format.html { render action: 'edit' }
          format.json { render json: @expense_detail.errors, status: :unprocessable_entity }
        end
      end
    elsif params[:commit] == "cancel"
      @expense_detail = ExpenseDetail.new
      
      respond_to do |format|
        format.js { render "cancel" }
      end
    end 
  end

  # DELETE /expense_details/1
  # DELETE /expense_details/1.json
  def destroy
    @expense_detail.destroy
    respond_to do |format|
      format.html { redirect_to expense_details_url, notice: "Expense detail was successfully deleted. " }
      format.json { head :no_content }
      format.js
    end
  end

  # multiple operation selected items 
  def multi_ops
    params[:expense_ids] ||= []

    if params[:delete_btn] 
      del_cnt = ExpenseDetail.delete(params[:expense_ids])
      redirect_to expense_details_url, notice: "#{del_cnt} records were successfully deleted. "
    else
      copied_cnt = ExpenseDetail.multi_copy(params[:expense_ids], params[:from_dtpker], params[:to_dtpker])
      redirect_to expense_details_url, notice: "#{copied_cnt} records were successfully copied. "
    end
  end   

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_expense_detail
      @expense_detail = ExpenseDetail.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def expense_detail_params
      params.require(:expense_detail).permit(:today, :expense_type_id, :payment_type_id, :amount, :comment)
    end
end
