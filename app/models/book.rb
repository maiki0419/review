class Book < ApplicationRecord
  belongs_to :user
  has_many :favorites, dependent: :destroy
  has_many :book_comments, dependent: :destroy

  validates :title,presence:true
  validates :body,presence:true,length:{maximum:200}

  scope :created_1week, -> {where(created_at: 1.week.ago.beginning_of_day .. Time.zone.now.end_of_day)}

  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end

  def self.looks(search,word)
    if search == "perfect"
      @book = Book.where("title LIKE?", "#{word}")
    elsif search == "forward"
      @book = Book.where("title LIKE?", "#{word}%")
    elsif search == "backward"
      @book = Book.where("title LIKE?",  "%#{word}")
    elsif search == "part"
      @book = Book.where("title LIKE?", "%#{word}%")
    else
      @book = Book.all
    end
  end

end
