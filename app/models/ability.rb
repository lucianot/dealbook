class Ability
  include CanCan::Ability

  def initialize(user)

    unless user
      user = User.new
      user.role = 'guest'
    end
    # user ||= User.new(:role => 'guest')

    if user.role == 'admin'
      can :manage, [ Company, Investor, Deal, Market, Location, Search ]
      can :manage, User, :role => User::ROLES-['admin']
    elsif user.role == 'moderator'
      can :manage, [ Company, Investor, Deal, Market, Location, Search ]
      can :read, User
    elsif user.role == 'normal'
      can :manage, [ Company, Investor, Search ]
      can [:read, :create, :update, :destroy], [ Deal ]
    # elsif user.role == 'banned'
    #   cannot :manage, :all
    else
      can :read, [ Company, Investor, Deal ]
      can [:create, :show], Search
    end

  end

end
