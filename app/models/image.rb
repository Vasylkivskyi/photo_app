class Image < ApplicationRecord
  belongs_to :user
  has_one_attached :photo

  after_destroy_commit :delete_image_from_s3

  private

  def delete_image_from_s3
    return unless persisted? # Check if the record exists

    photo.purge if photo.attached?
    # Delete from S3 and perform any other necessary actions
  end
end
