class PlayersController < ApplicationController
  before_action :player, only: [:show]

  def index; end

  def show; end

  private

  def player
    @player ||= Player.find(params[:id])
  end
end
