class Ability
  include CanCan::Ability

  def initialize(user)
    @user = user

    if @user
      @user.is_admin? ? admin_abilities : user_abilities
    else
      guest_abilities
    end
  end

  def admin_abilities
    can :access, :rails_admin
    can :dashboard
    can :manage, :all
  end

  def user_abilities
    guest_abilities
    can :read, @user
    can :manage, Order, user: @user
    can :manage, OrderItem, user: @user
    can :create, Rating
    can :update, Rating, user: @user
  end

  def guest_abilities
    can :read, [Book, Category, Author, Rating]
  end
end
