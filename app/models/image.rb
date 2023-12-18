class Image < ApplicationRecord
  belongs_to :user
  has_one_attached :photo
  validates :photo, presence: true
  validate :image_attachment_type

  after_destroy_commit :delete_image_from_s3

  private

  def delete_image_from_s3
    return unless persisted? # Check if the record exists

    photo.purge if photo.attached?
    # Delete from S3 and perform any other necessary actions
  end

  def image_attachment_type
    if photo.attached? && !photo.content_type.start_with?('image/')
      errors.add(:photo, 'must be an image file')
      photo.purge if photo.persisted? # Remove the attachment
    end
  end
end
