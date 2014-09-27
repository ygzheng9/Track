class LaborClaimsController < ApplicationController
  before_action :set_labor_claim, only: [:show, :edit, :update, :destroy]

  # GET /labor_claims
  # GET /labor_claims.json
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
    
    @labor_claims = LaborClaim.where(["today >= ? and today <= ?", params[:from_date_picker], params[:to_date_picker]]).order(today: :asc)
    @labor_claim = LaborClaim.new
  end

  # GET /labor_claims/1
  # GET /labor_claims/1.json
  def show
    if params[:opt] == "copy"
      target_date = Date.today

      @labor_claim.CopyWholeDay(target_date)

      redirect_to action: :index 
    end 
  end

  # GET /labor_claims/new
  def new
    @labor_claim = LaborClaim.new
  end

  def new_v2
    @labor_claim = LaborClaim.new
  end  

  # GET /labor_claims/1/edit
  def edit
  end

  # POST /labor_claims
  # POST /labor_claims.json
  def create
    if params[:commit] == 'Go'
      @labor_claim = LaborClaim.new(labor_claim_params)

      respond_to do |format|
        if @labor_claim.save
          format.html { redirect_to labor_claims_path, notice: 'Labor claim was successfully created.' }
          format.json { render action: 'show', status: :created, location: @labor_claim }
          format.js
        else
          format.html { render action: 'new_v2' }
          format.json { render json: @labor_claim.errors, status: :unprocessable_entity }
        end
      end
    elsif  params[:commit] == 'Cancel'
      respond_to do |format|
        format.js { render "cancel" }
      end 
    end 
  end

  # PATCH/PUT /labor_claims/1
  # PATCH/PUT /labor_claims/1.json
  def update
    if params[:commit] == "Go"
      respond_to do |format|
        if @labor_claim.update(labor_claim_params)
          format.html { redirect_to labor_claims_path, notice: 'Labor claim was successfully updated.' }
          format.json { head :no_content }
          format.js
        else
          format.html { render action: 'edit' }
          format.json { render json: @labor_claim.errors, status: :unprocessable_entity }
        end
      end
    elsif  params[:commit] == 'Cancel'
      respond_to do |format|
        format.js { render "cancel" }
      end 
    end    
  end

  # DELETE /labor_claims/1
  # DELETE /labor_claims/1.json
  def destroy
    @labor_claim.destroy
    respond_to do |format|
      format.html { redirect_to labor_claims_url }
      format.json { head :no_content }
      format.js
    end
  end

  # multiple operation selected items 
  def multi_ops
    params[:claim_ids] ||= []

    if params[:update_btn]
      @claims = LaborClaim.find(params[:claim_ids])
      @claim = LaborClaim.new

      render "batch_update"
    elsif params[:delete_btn] 
      del_cnt = LaborClaim.delete(params[:claim_ids])
      redirect_to labor_claims_url, notice: "#{del_cnt} records were successfully deleted. "
    else
      copied_cnt = LaborClaim.multi_copy(params[:claim_ids], params[:from_dtpker], params[:to_dtpker])
      redirect_to labor_claims_url, notice: "#{copied_cnt} records were successfully copied. "
    end
  end  

  def batch_update
    # change code and hours 
    @claims = LaborClaim.find(params[:claim_ids])
    cnt = @claims.count

    claim_params = params.require(:labor_claim).permit(:project_id, :hours, :comment)
    new_val = claim_params.reject { |k,v| v.blank? }

    @claims.each do |claim|
      claim.update_attributes(new_val)
    end 

    redirect_to labor_claims_url, notice: "#{cnt} records were successfully updated. "

=begin
    @claims.reject! do |claim|
      claim.update_attributes(params[:labor_claim].reject { |k,v| v.blank? })
    end
    
    if @claims.empty?
      redirect_to labor_claims_url, notice: "#{cnt} records were successfully updated. "
    else
      @claim = Product.new(params[:labor_claim])
      render "batch_update", notice: "#{@claims.count} records failed to update. "
    end 
=end    

  end 
  
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_labor_claim
      @labor_claim = LaborClaim.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def labor_claim_params
      params.require(:labor_claim).permit(:today, :project_id, :hours, :comment)
    end
end
