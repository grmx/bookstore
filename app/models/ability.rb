class Ability
  include CanCan::Ability

  def initialize(user)
    if user
      if user.is_admin?
        can :access, :rails_admin
        can :dashboard
        can :manage, :all
      else
        can :read, :all
        can :create, Rating
        can :update, Rating, user: user
      end
    else
      can :read, :all
    end
  end
end
