class CardsController < ApplicationController
  before_action :set_card, only: [:show, :edit, :update, :destroy]

  # GET /cards
  # GET /cards.json
  
  rescue_from ActiveRecord::RecordNotFound, with: :no_cards_found
  def index
    if signed_in?
      @cards = Card.all
    else
      flash[:danger] = "Sorry, you need to sign in or create an account before you can review your cards."
      redirect_to :back
    end
  end

  # GET /cards/1
  # GET /cards/1.json
  def show
    if !signed_in? || Card.count < 1
      flash[:danger] = "Sorry, you need to sign in or create an account before you can review your cards."
      redirect_to :back
    end
  end

  # GET /cards/new
  def new
    @card = Card.new
  end

  # GET /cards/1/edit
  def edit
  end

  # POST /cards
  # POST /cards.json
  def create
    @card = Card.new(card_params)

    respond_to do |format|
      if @card.save
        format.html { redirect_to cards_url, notice: 'Card was successfully created.' }
        format.json { render :show, status: :created, location: @card }
      else
        format.html { render :new }
        format.json { render json: @card.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /cards/1
  # PATCH/PUT /cards/1.json
  def update
    respond_to do |format|
      if @card.update(card_params)
        format.html { redirect_to cards_url, notice: 'Card was successfully updated.' }
        format.json { render :show, status: :ok, location: @card }
      else
        format.html { render :edit }
        format.json { render json: @card.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /cards/1
  # DELETE /cards/1.json
  def destroy
    @card.destroy
    respond_to do |format|
      format.html { redirect_to cards_url, notice: 'Card was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_card
      @card = Card.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def card_params
      params.require(:card).permit(:question, :answer, :score, :user_id)
    end
    
    def no_cards_found
        if signed_in?
            redirect_to cards_path
        else
            flash[:danger] = "Sorry, you need to sign in or create an account before you can review your cards."
            redirect_to :back
        end
    end
    
end
