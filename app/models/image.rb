class Image < ApplicationRecord
  belongs_to :user
  has_many_attached :photo
end
