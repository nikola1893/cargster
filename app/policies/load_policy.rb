class LoadPolicy < ApplicationPolicy
  def update?
    record.user == user
    # record: the restaurant passed to the `authorize` method in controller
    # user: the `current_user` signed in with Devise
  end

  # def show?
  #   if record.status == false
  #     record.user == user
  #   else
  #     true
  #   end
  # end

  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    # def resolve
    #   scope.all
    # end
  end
end
