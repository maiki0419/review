class Book < ApplicationRecord
  belongs_to :user
  has_many :favorites, dependent: :destroy
  has_many :book_comments, dependent: :destroy
  has_many :categories, dependent: :destroy
  accepts_nested_attributes_for :categories, allow_destroy: true
  is_impressionable counter_cache: true

  validates :title,presence:true
  validates :body,presence:true,length:{maximum:200}
  validates :rate,presence:true

  scope :created_1week, -> {where(created_at: 1.week.ago.beginning_of_day .. Time.zone.now.end_of_day)}

# 7b
  scope :create_today, -> {where(created_at: Time.zone.now.all_day)}
  scope :create_yesterday, -> {where(created_at: 1.day.ago.all_day)}
  scope :create_thisweek, -> {where(created_at: Date.today.prev_week(:saturday) .. Date.today-(Date.today.wday-5))}
  scope :create_lastweek, -> {where(created_at: Date.today-(Date.today.wday-6)-14 .. Date.today-(Date.today.wday-5)-7)}

# 8b
  scope :create_today, -> {where(created_at: Time.zone.now.all_day)}
  scope :create_1day, -> {where(created_at: 1.day.ago.all_day)}
  scope :create_2day, -> {where(created_at: 2.day.ago.all_day)}
  scope :create_3day, -> {where(created_at: 3.day.ago.all_day)}
  scope :create_4day, -> {where(created_at: 4.day.ago.all_day)}
  scope :create_5day, -> {where(created_at: 5.day.ago.all_day)}
  scope :create_6day, -> {where(created_at: 6.day.ago.all_day)}



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
