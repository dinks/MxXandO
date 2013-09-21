class Game < ActiveRecord::Base

  include Board

  def self.random_game(initiator)
    opponent = initiator.random_opponent
    return nil unless opponent

    # The first player gets x !!!
    players = [initiator.id, opponent.id].shuffle

    game = Game.create(player_x: players[0], player_o: players[1])
    game.start!

    game
  end

  def played_by?(user)
    player_X == user || player_O == user
  end

  def opponent_of(user)
    if played_by?(user)
      player_X == user ? player_O : player_X
    else
      nil
    end
  end

end
