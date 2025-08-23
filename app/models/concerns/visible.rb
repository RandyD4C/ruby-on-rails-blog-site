module Visible
  extend ActiveSupport::Concern

  VALID_STATUSES = [ "public", "private", "archived" ]

  included do
    validates :status, inclusion: { in: VALID_STATUSES }
    scope :public_status,   -> { where(status: "public") }
    scope :private_status,  -> { where(status: "private") }
    scope :archived_status, -> { where(status: "archived") }
    scope :active,          -> { where.not(status: "archived") }
  end

  def public?
    status == "public"
  end

  def private?
    status == "private"
  end

  def archived?
    status == "archived"
  end

  class_methods do
    def public_count
      where(status: "public").count
    end

    def private_count
      where(status: "private").count
    end

    def archived_count    
      where(status: "archived").count
    end
  end
end
