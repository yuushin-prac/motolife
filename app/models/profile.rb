class Profile < ApplicationRecord
  belongs_to :user

  validates :name, presence: true, length: { maximum: 64 }
end
