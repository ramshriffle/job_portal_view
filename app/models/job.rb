class Job < ApplicationRecord
  belongs_to :user
  has_many :user_applications, dependent: :destroy
  
  validates :job_title, :description, :location, :salary, presence: true
  scope :search_job_by_title, ->(title) {where("job_title LIKE ?", "#{title}%")}
  
  # def self.search_job_by_title(title)
  #   where("job_title LIKE ?", "#{title}%")
  # end
end
