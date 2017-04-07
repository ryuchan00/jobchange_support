class Link < ApplicationRecord
  validates :provider, presence: true, length: { maximum: 255 }
  validates :link, presence: true, length: { maximum: 255 }

  belongs_to :user
end
