class App < ApplicationRecord
	validates :title, presence: true
	belongs_to :user
	has_many :comments
	belongs_to :category
	mount_uploader :image, ImageUploader

	App.find_each do |app|
  app.image.recreate_versions! if app.image?
	end

	def publish!
		self.is_hidden = false
		self.save
	end

	def hide!
		self.is_hidden = true
		self.save
	end

	scope :published, -> { where(is_hidden: false) }
	scope :recent, -> { order("created_at DESC")}
end
