class Ability
  include CanCan::Ability

  def initialize(user)

    unless user
      user = User.new
      user.role = 'guest'
    end
    # user ||= User.new(:role => 'guest')

    if user.role == 'admin'
      can :manage, [ Company, Investor, Deal, Market, Location ]
      can :manage, User, :role => User::ROLES-['admin']
    elsif user.role == 'moderator'
      can :manage, [ Company, Investor, Deal, Market, Location ]
    elsif user.role == 'normal'
      can :manage, [ Company, Investor, Deal ]
    # elsif user.role == 'banned'
    #   cannot :manage, :all
    else
      can :read, [ Company, Investor, Deal ]
    end

  end

end
