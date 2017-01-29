class App < ApplicationRecord
	validates :title, presence: true
	belongs_to :user
	has_many :comments
	mount_uploader :image, ImageUploader

	def publish!
		self.is_hidden = false
		self.save
	end

	def hide!
		self.is_hidden = true
		self.save
	end
end
