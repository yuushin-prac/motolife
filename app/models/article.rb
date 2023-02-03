class Article < ApplicationRecord

  belongs_to :user
  validates :title, presence: true, length: { maximum: 255 }
  validates :body, presence: true

  attachment :image
end
