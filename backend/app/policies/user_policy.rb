# app/policies/user_policy.rb
class UserPolicy < ApplicationPolicy
  def index?
    user.admin?
  end

  def show?
    user.admin? || (user.jugador? && user.id == record.id)
  end

  def create?
    user.admin?
  end

  def update?
    user.admin? || (user.jugador? && user.id == record.id)
  end

  def destroy?
    user.admin?
  end

  class Scope < Scope
    def resolve
      if user.admin?
        scope.all
      elsif user.jugador?
        scope.where(id: user.id)
      else
        scope.none
      end
    end
  end
end
