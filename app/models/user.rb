class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :books, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :book_comments, dependent: :destroy
  has_many :entries, dependent: :destroy
  has_many :messages, dependent: :destroy

  has_many :relationships,foreign_key: "follower_id",dependent: :destroy
  has_many :followers, through: :relationships,source: :followed

  has_many :revers_of_relationships,class_name: "Relationship",foreign_key: "followed_id",dependent: :destroy
  has_many :followeds,through: :revers_of_relationships,source: :follower




  has_one_attached :profile_image

  validates :name, length: { minimum: 2, maximum: 20 }, uniqueness: true
  validates :introduction,length: {maximum: 50}


  def get_profile_image(size)
    unless profile_image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      profile_image.attach(io: File.open(file_path),filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    profile_image.variant(resize: size).processed
  end

  def followed_by?(user)
    relationships.exists?(followed_id: user.id)
  end

  def self.looks(search,word)

    if search == "perfect"
      @user = User.where("name LIKE?", "#{word}")
    elsif search == "forward"
      @user = User.where("name LIKE?", "#{word}%")
    elsif search == "backward"
      @user = User.where("name LIKE?", "%#{word}")
    elsif search == "part"
      @user = User.where("name LIKE?", "%#{word}%")
    else
      @user = User.all
    end

  end




end
