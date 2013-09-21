class User < ActiveRecord::Base

  include Player

  scope :all_online,  -> { where(online: true).limit(10).pluck(:uuid) }
  scope :all_idle,    -> { where(online: true, state: 'resting').limit(10) }
  scope :except_user, -> (user_id){ where.not(id: user_id) }

  def is_online!
    update_attributes(online: true)
  end

  def is_offline!
    update_attributes(online: false)
  end

  def random_opponent
    idle_users = User.all_idle.except_user(self.id).load
    idle_users.length == 0 ? nil : idle_users[Random.rand(idle_users.length)]
  end

  private
    def user_params
      params.permit(:name, :uuid, :state, :online)
    end

end
