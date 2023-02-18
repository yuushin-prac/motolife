class Article < ApplicationRecord
  validates :title, presence: true, length: { maximum: 64 }
  validates :content, presence: true
  belongs_to :user
  has_many :comments, dependent: :destroy
  attachment :image
  has_rich_text :content
end
