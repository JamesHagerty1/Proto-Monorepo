class User < ApplicationRecord
  devise :database_authenticatable, :recoverable, :rememberable, :validatable,
         :confirmable

  belongs_to :organization

  enum :role, { member: "member", admin: "admin" }, validate: true
end
