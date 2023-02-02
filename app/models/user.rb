class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :email, {presence: true, uniqueness: { case_sensitive: false }}

  has_one :profile, dependent: :destroy
  has_many :articles, dependent: :destroy
  delegate :name, to: :profile
end
