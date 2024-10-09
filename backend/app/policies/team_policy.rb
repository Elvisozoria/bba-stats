# app/policies/team_policy.rb
class TeamPolicy < ApplicationPolicy
  def index?
    user.admin? || user.supervisor?
  end

  def show?
    user.admin? || user.supervisor?
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
      else
        scope.none
      end
    end
  end
end
