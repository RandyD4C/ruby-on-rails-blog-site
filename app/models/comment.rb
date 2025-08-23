class Comment < ApplicationRecord
  include Visible

  belongs_to :article
  belongs_to :user

  after_validation :set_commenter
  validates :commenter, presence: true
  validates :body, presence: true
  validates :status, presence: true

  private

  def set_commenter
    self.commenter = User.find(user_id).name if user_id.present?
  end
end
