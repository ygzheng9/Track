class GoSingleController < ApplicationController
  def go
    
=begin
    date = params[:selected_date]
    selected_date = Date.new date["(1i)"].to_i, date["(2i)"].to_i, date["(3i)"].to_i

    logger.debug "selected date: #{selected_date}" 
    filter = ["today = ?", selected_date ]
=end

    from_date = Date.strptime(params[:from_date_picker], '%m/%d/%Y')
    to_date = Date.strptime(params[:to_date_picker], '%m/%d/%Y')
    # from_date = Date.strptime(params[:from_date_picker])
    # to_date = Date.strptime(params[:to_date_picker])

    logger.debug "from date: #{from_date}" 

    filter = ["today between ? and ?", from_date, to_date ] 

    # expense details 
    @expense_details = ExpenseDetail.where(filter)
    @expense_detail = ExpenseDetail.new

    # labor claims
    @labor_claims = LaborClaim.where(filter)
    @labor_claim = LaborClaim.new

    # working location
    @working_locations = WorkingLocation.where(filter)
    
    @working_location = WorkingLocation.new
    @cities = City.all 
    @sites = @cities.first.sites      

    # stay nights
    @stay_nights = StayNight.where(filter)
    @stay_night = StayNight.new

    respond_to do |format|
      format.html
      format.js { render :go_tabs }
    end 

  end


  def TestForm
    @stay_night = StayNight.last
    
    respond_to do |format|
      format.html { render :test_form }
    end     
  end 

  def TestCopy
    @labor_claims = LaborClaim.all.order(today: :asc)
    @labor_claim = LaborClaim.new

    respond_to do |format|
      format.html { render :test_copy }
    end      
  end 


  def BundleDupSelection
    respond_to do |format|
      format.html { render :bundle_dup_selection }
    end     
  end 

  def TestBundleDup    
    @src_date = params[:src_date_picker]
    @fm_date = params[:fm_dtp]
    @to_date = params[:to_dtp]

    # ExpenseDetail.BundleCopy(@src_date, @fm_date, @to_date)

    respond_to do |format|
      format.html { render :bundle_dup }
    end   
  end 

end
