class FoosController < ApplicationController
  before_action :require_login

  def index
    @shares = current_user.shares
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

    profit = share.player.get_current_value * amount
    share.amount -= amount
    share.amount = 0 if share.amount < 0

    if share.amount == 0 then
      share.destroy
    else
      share.save
    end

    current_user.credit += profit
    current_user.save

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

    if cost > current_user.credit
      flash[:error] = 'Buy operation could not complete. Not enough credit.'
      redirect_to foos_path and return
    end

    share = Share.new
    share.amount = amount
    share.buy_price = player.get_current_value
    share.player = player
    share.user = current_user
    share.save

    current_user.credit -= cost
    current_user.save

    flash[:info] = 'Buy operation completed successfully'
    redirect_to foos_path
  end

end
