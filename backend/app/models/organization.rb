class Organization < ApplicationRecord
  has_many :users, dependent: :restrict_with_error

  validates :name, presence: true # TODO -- consider need for uniqueness
end
