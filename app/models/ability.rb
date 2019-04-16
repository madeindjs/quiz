# frozen_string_literal: true

class Ability
  include CanCan::Ability

  # :read, :create, :update and :destroy.
  def initialize(user)
    can :read, :all
    can :create, User


    if user.present?
      can :create, Question
      can :modify, Question, user_id: user.id

      can :create, Response
      can :modify, Response, user_id: user.id

      can :modify, User, id: user.id

      if user.admin? || user.super_admin?
        can :modify, Response
        can :modify, Question
      end

      if user.super_admin?
        can :modify, User
      end
    end
  end
end
