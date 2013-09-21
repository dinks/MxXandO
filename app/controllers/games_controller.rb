class GamesController < ApplicationController

  def new

  end

  def create
    random_game = Game.random_game @_current_user
    unless random_game
      flash[:error] = "Cant find a User to play with right now. Please try after some time .."
      redirect_to new_game_path
    else
      msg = {
        opponent: random_game.opponent_of(@_current_user).try(:uuid),
        game_url: game_path(random_game)
      }

      $redis.publish 'user.game.invite', msg.to_json

      redirect_to game_path(random_game)
    end
  end

  def show
    game = Game.find_by_id(params[:id])
    unless game.played_by?(@_current_user)
      flash[:error] = "You are not a part of this game !!"
      redirect_to new_game_path
    end
  end
end
