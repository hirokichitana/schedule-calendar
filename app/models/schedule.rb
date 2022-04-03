class Schedule < ApplicationRecord

  validates :title, presence: true
  validates :content, presence: true
  validates :start_time, presence: true
  validates :end_time, presence: true

  belongs_to :user
  has_many :comments

end
