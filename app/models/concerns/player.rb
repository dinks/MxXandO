module Player
  extend ActiveSupport::Concern

  included do
    has_many :games_X, class_name: "Game", foreign_key: "player_x"
    has_many :games_O, class_name: "Game", foreign_key: "player_o"

    before_create :set_random_uuid

    state_machine initial: :resting do

      after_transition on: :resign, do: :after_resign
      after_transition on: :play,   do: :after_play
      after_transition on: :won,    do: :after_win
      after_transition on: :lost,   do: :after_loss

      state :resting
      state :playing

      event :play do
        transition :resting => :playing
      end

      event :won do
        transition :playing => :resting
      end

      event :lost do
        transition :playing => :resting
      end

      event :resign do
        transition :playing => :resting
      end
    end

  end

  # Update he Game Status after Resignation
  def after_resign

  end

  # Update he Game Status after start of Play
  def after_play

  end

  # Update he Game Status after game Win
  def after_win

  end

  # Update he Game Status after game Loss
  def after_loss

  end

  def set_random_uuid
    self.uuid = SecureRandom.hex
  end

end
