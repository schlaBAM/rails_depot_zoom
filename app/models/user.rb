# frozen_string_literal: true
class User < ApplicationRecord
  validates :name, presence: true, uniqueness: { case_sensitive: false }
  has_secure_password

  after_destroy :ensure_one_admin_remains

  class NoAdminsLeft < StandardError; end

  private

  def ensure_one_admin_remains
    if User.count.zero?
      raise NoAdminsLeft, "Can't delete last user. Make another one before ragekicking this one."
    end
  end
end
