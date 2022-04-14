class Comment < ApplicationRecord
  validates :text, presence: true

  belongs_to :schedule
  belongs_to :user
end
