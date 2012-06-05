class Ability
  include CanCan::Ability

  def initialize(user)
      user ||= User.new(:role => 'guest')   # guest user (not logged in)
      if user.role == 'admin'
        can :manage, [ Company, Investor, Deal, Market, Location ]
        can :manage, User, :role => User::ROLES-['admin']
      elsif user.role == 'moderator'
        can :manage, [ Company, Investor, Market, Location ]
      elsif user.role == 'normal'
        can :manage, [ Company, Investor ]
      # elsif user.role == 'banned'
      #   cannot :manage, :all
      else
        can :read, [ Company, Investor ]
      end
  end

  # 1. include condition
  # 2. create scope, include scope

end
