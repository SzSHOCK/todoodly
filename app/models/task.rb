class Task < ActiveRecord::Base
  attr_accessible :completed, :description, :list_id

  belongs_to :list
  scope :completed, where(:completed => true)
  scope :incompleted, where(:completed => false)

  validates :description, :presence =>true
end
