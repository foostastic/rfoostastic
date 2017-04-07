class FoosController < ApplicationController
  before_action :require_login

  def index
    @shares = @_current_user_season.shares
    @players = Player.order(:division).order(points: :desc).all
  end

  def sell
    id = params.require(:id)
    amount = params.require(:amount)
    share = Share.find(id)
    if share.nil? then
      flash[:error] = 'Sell operation could not be completed'
      redirect_to foos_path and return
    end
    amount = amount.to_i
    if amount <= 0
      flash[:error] = 'Sell operation could not complete. Invalid amount.'
      redirect_to foos_path and return
    end

    @_current_user_season.sell share, amount

    flash[:info] = 'Sell operation completed successfully'
    redirect_to foos_path
  end

  def buy
    id = params.require(:id)
    amount = params.require(:amount)
    player = Player.find(id)
    amount = amount.to_i
    if player.nil? then
      flash[:error] = 'Buy operation could not complete. Requested player not found.'
      redirect_to foos_path and return
    end
    cost = player.get_current_value * amount

    if amount <= 0 or amount > player.get_available_stocks
      flash[:error] = 'Buy operation could not complete. Check player availability.'
      redirect_to foos_path and return
    end

    if cost > @_current_user_season.credit
      flash[:error] = 'Buy operation could not complete. Not enough credit.'
      redirect_to foos_path and return
    end

    @_current_user_season.buy player, amount

    flash[:info] = 'Buy operation completed successfully'
    redirect_to foos_path
  end

end
