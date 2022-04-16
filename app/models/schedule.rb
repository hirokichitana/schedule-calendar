class Schedule < ApplicationRecord

  with_options presence: true do
    validates :title
    validates :content
    validates :start_time
    validates :end_time
  end

  validates :zip_code, format: { with: /\A\d{0,7}\z/ }


  belongs_to :user
  has_many :comments

end
