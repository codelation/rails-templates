class Charge < ActiveRecord::Base
  belongs_to :invoice, touch: true

  scope :chronological, -> { order(created_at: :asc) }

  enum status: {
    failed: 0,
    succeeded:  1
  }
end
