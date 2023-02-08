class Article < ApplicationRecord
  validates :title, presence: true, length: { maximum: 64 }
  validates :body, presence: true
  belongs_to :user
  attachment :image
end
