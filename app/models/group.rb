class Group < ApplicationRecord
  has_many :group_users, dependent: :destroy
  has_one_attached :image_id

  validates :name,presence: true,length: {maximum: 10}

  def get_image_id(size)
    unless image_id.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      image_id.attach(io: File.open(file_path),filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    image_id.variant(resize: size).processed
  end

  def group_by?(group)
    
  end

end
