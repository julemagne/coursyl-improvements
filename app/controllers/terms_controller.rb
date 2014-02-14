class TermsController < ApplicationController
  before_action :authenticate_user!
  before_action :admin_only!
  before_action :set_term, only: [:edit, :update, :destroy]

  # GET /terms
  def index
    @terms = Term.all
  end

  # GET /terms/new
  def new
    @term = Term.new
  end

  # GET /terms/1/edit
  def edit
  end

  # POST /terms
  def create
    @term = Term.new(term_params)

    respond_to do |format|
      if @term.save
        format.html { redirect_to terms_url, flash: {success: 'Term was successfully created.'} }
      else
        format.html { render action: 'new' }
      end
    end
  end

  # PATCH/PUT /terms/1
  def update
    respond_to do |format|
      if @term.update(term_params)
        format.html { redirect_to terms_url, flash: {success: 'Term was successfully updated.'} }
      else
        format.html { render action: 'edit' }
      end
    end
  end

  # DELETE /terms/1
  def destroy
    @term.destroy
    respond_to do |format|
      format.html { redirect_to terms_url }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_term
      @term = Term.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def term_params
      params.require(:term).permit(:name, :starts_on, :ends_on, :school_id)
    end
end
