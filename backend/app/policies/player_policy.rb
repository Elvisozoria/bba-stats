# app/policies/player_policy.rb
class PlayerPolicy < ApplicationPolicy
  def index?
    user.admin? || user.supervisor? || user.jugador?
  end

  def show?
    user.admin? || user.supervisor? || (user.jugador? && user.player_id == record.id)
  end

  def create?
    user.admin? || user.supervisor?
  end

  def update?
    user.admin? || user.supervisor? || (user.jugador? && user.player_id == record.id)
  end

  def destroy?
    user.admin? || user.supervisor?
  end

  class Scope < Scope
    def resolve
      if user.admin? || user.supervisor?
        scope.all
      elsif user.jugador?
        scope.where(id: user.player_id)
      else
        scope.none
      end
    end
  end
end
