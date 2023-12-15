class AddAttachmentPhotoToImages < ActiveRecord::Migration[6.1]
  def up
    add_attachment :images, :avatar
  end

  def down
    remove_attachment :images, :avatar
  end
end
