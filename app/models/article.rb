class Article < ApplicationRecord
  validates :title, presence: true, length: { maximum: 64 }
  validates :content, presence: true
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :like_users, through: :likes, source: :user
  has_rich_text :content
  attachment :image
  enum category: { blog: 0, maintenance_note: 1 }

  scope :show_blog, -> { where(category: 0) }
  scope :show_maintenance_note, -> { where(category: 1) }
end
