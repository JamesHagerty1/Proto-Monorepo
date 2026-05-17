class User < ApplicationRecord
  # Notice: `:registerable` is stripped away, because this app defines its
  # signup flow
  devise :database_authenticatable, :recoverable, :rememberable, :validatable,
         :confirmable

  belongs_to :organization

  enum :role, { member: "member", admin: "admin" }, validate: true
end
