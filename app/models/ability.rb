class Ability
  include CanCan::Ability

  def initialize(user)
    if user
      if user.is_admin?
        can :access, :rails_admin
        can :dashboard
        can :manage, :all
      else
        can :read,   [Book, Category, Author, Rating, User]
        can :manage, Order,     user: user
        can :manage, OrderItem, user: user
        can :create, Rating
        can :update, Rating,    user: user
      end
    else
      can :read, [Book, Category, Author, Rating]
    end
  end
end
