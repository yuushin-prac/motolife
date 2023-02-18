class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :article

  validates :comment_content, presence: true, length: { maximum:140 }
end
