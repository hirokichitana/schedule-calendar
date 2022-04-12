class Schedule < ApplicationRecord

  validates :title, presence: true
  validates :content, presence: true
  validates :start_time, presence: true
  validates :end_time, presence: true
  validates :zip_code, format: { with: /\A\d{7}\z/ }


  belongs_to :user
  has_many :comments

end
