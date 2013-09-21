module Board
  extend ActiveSupport::Concern

  included do
    has_one :player_X, class_name: "User", foreign_key: "id", primary_key: "player_x"
    has_one :player_O, class_name: "User", foreign_key: "id", primary_key: "player_o"

    state_machine initial: :created do

      after_transition on: :start,    do: :after_start
      after_transition on: :abandon,  do: :after_abandon
      after_transition on: :end,      do: :after_end

      state :created
      state :started
      state :abandoned
      state :ended

      event :start do
        transition :created => :started
      end

      event :abandon do
        transition :started => :abandoned
      end

      event :end do
        transition :started => :ended
      end

    end
  end

  def after_start
    self.player_X.play!
    self.player_O.play!
  end

  def after_abandon

  end

  def after_end
    self.player_X.resign!
    self.player_O.resign!
  end
end
