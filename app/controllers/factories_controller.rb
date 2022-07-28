class FactoriesController < ApplicationController
  before_action :factory, only: [:upgrade]

  def upgrade
    flash[:error] = 'You can only upgrade your own factory' if @factory.player != current_user

    if @factory.can_upgrade? && @factory.player == current_user
      @factory.upgrade
      flash[:notice] = 'Factory successfully upgraded'
    else
      flash[:error] = 'Not enough resources to upgrade'
    end

    redirect_to root_url
  end

  private

  def factory
    @factory = Factory.find(params[:id])
  end
end
