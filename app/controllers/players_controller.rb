class PlayersController < ApplicationController
  before_action :player, only: [:show]
  before_action :all_players, only: [:index]

  def index; end

  def show; end

  private

  def player
    @player ||= current_user
  end

  def all_players
    @players ||= Player.all
  end
end
