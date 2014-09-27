class ColleaguesController < ApplicationController
  before_action :set_colleague, only: [:show, :edit, :update, :destroy]

  # GET /colleagues
  # GET /colleagues.json
  def index
    @colleagues = Colleague.all
  end

  # GET /colleagues/1
  # GET /colleagues/1.json
  def show
  end

  # GET /colleagues/new
  def new
    @colleague = Colleague.new
  end

  # GET /colleagues/1/edit
  def edit
  end

  # POST /colleagues
  # POST /colleagues.json
  def create
    @colleague = Colleague.new(colleague_params)

    respond_to do |format|
      if @colleague.save
        format.html { redirect_to colleagues_url, notice: 'Colleague was successfully created.' }
        format.json { render action: 'show', status: :created, location: @colleague }
      else
        format.html { render action: 'new' }
        format.json { render json: @colleague.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /colleagues/1
  # PATCH/PUT /colleagues/1.json
  def update
    respond_to do |format|
      if @colleague.update(colleague_params)
        format.html { redirect_to colleagues_url, notice: 'Colleague was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @colleague.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /colleagues/1
  # DELETE /colleagues/1.json
  def destroy
    @colleague.destroy
    respond_to do |format|
      format.html { redirect_to colleagues_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_colleague
      @colleague = Colleague.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def colleague_params
      params.require(:colleague).permit(:name, :remark)
    end
end
