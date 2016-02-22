class StaticController < ApplicationController
  def home
    @card = Card.new
  end

  def about
  end
  
      # Never trust parameters from the scary internet, only allow the white list through.
    def card_params
      params.require(:card).permit(:question, :answer, :score, :user_id)
    end
end
