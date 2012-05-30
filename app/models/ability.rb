class Ability
  include CanCan::Ability

  def initialize(user)
      user ||= User.new   # guest user (not logged in)
      if user.has_role? :admin
        can :manage, :all
      elsif user.has_role? :moderator
        can :manage, [ Company, Investor, Deal, Market, Location ]
      elsif user.has_role? :regular
        can [:create, :update], [ Company, Investor, Deal ]
      elsif user.has_role? :banned
        cannot :manage, :all
      else
        can :read, [ Company, Investor, Deal ]
      end

  end
end
