class Comment < ApplicationRecord
	belongs_to :user
	belongs_to :app

	validates :content, presence: true
end
