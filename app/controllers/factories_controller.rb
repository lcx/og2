class FactoriesController < ApplicationController
  before_action :factory, only: [:upgrade]

  def upgrade
    if @factory.player != current_user
      flash[:error] = 'You can only upgrade your own factory'
    end

    if @factory.can_upgrade?
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
