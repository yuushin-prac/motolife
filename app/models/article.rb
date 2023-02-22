class Article < ApplicationRecord
  validates :title, presence: true, length: { maximum: 64 }
  validates :content, presence: true
  belongs_to :user
  has_many :comments, dependent: :destroy
  attachment :image
  has_rich_text :content
  enum category: { blog: 0, maintenance_note: 1 }

  scope :show_blog, -> { where(category: 0) }
  scope :show_maintenance_note, -> { where(category: 1) }
end
