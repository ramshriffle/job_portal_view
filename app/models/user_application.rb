class UserApplication < ApplicationRecord
  belongs_to :job
  belongs_to :user
  has_one_attached :resume

  enum status: {applied: "applied", accept: "accept", reject: "reject"} ,_prefix: :status
  validates :job_id,uniqueness: {scope: :user_id, message: "You have already apply for the job"}
  validates :resume, presence: true
end
