# app/policies/action_policy.rb
class ActionPolicy < ApplicationPolicy
  def index?
    user.admin? || user.supervisor? || user.anotador?
  end

  def show?
    user.admin? || user.supervisor? || (user.anotador? && record.match.anotador_id == user.id)
  end

  def create?
    user.admin? || user.supervisor? || (user.anotador? && record.match.anotador_id == user.id)
  end

  def update?
    user.admin? || user.supervisor? || (user.anotador? && record.match.anotador_id == user.id)
  end

  def destroy?
    user.admin? || user.supervisor? || (user.anotador? && record.match.anotador_id == user.id)
  end

  class Scope < Scope
    def resolve
      if user.admin? || user.supervisor?
        scope.all
      elsif user.anotador?
        scope.joins(:match).where(matches: { anotador_id: user.id })
      else
        scope.none
      end
    end
  end
end
