# app/policies/match_policy.rb
class MatchPolicy < ApplicationPolicy
  def index?
    user.admin? || user.supervisor? || user.anotador?
  end

  def show?
    user.admin? || user.supervisor? || (user.anotador? && record.anotador_id == user.id)
  end

  def create?
    user.admin? || user.supervisor?
  end

  def update?
    user.admin? || user.supervisor?
  end

  def destroy?
    user.admin?
  end

  class Scope < Scope
    def resolve
      if user.admin? || user.supervisor?
        scope.all
      elsif user.anotador?
        scope.where(anotador_id: user.id)
      else
        scope.none
      end
    end
  end
end
