class Api::V1::SignupsController < ApplicationController
  # Creates organization AND its owner's / first user's account
  def create
    organization = Organization.new(name: signup_params[:organization_name])
    user = organization.users.build(
      email: signup_params[:email],
      password: signup_params[:password],
      password_confirmation: signup_params[:password_confirmation],
      role: :admin, # User who creates org should be an admin
    )

    ActiveRecord::Base.transaction do
      organization.save!
      user.save!
    end

    render json: { message: "Organization and user created successfully" }, 
           status: :created
  rescue
    render json: { errors: signup_errors(organization, user) }, 
           status: :unprocessable_entity
  end

  private

  def signup_params
    params.permit(:organization_name, :email, :password,
                  :password_confirmation)
  end

  # TODO -- find nice way to document errors spec, to make things easier for
  # frontend development
  def signup_errors(organization, user)
    errors = {}
    errors[:email] = user.errors[:email] if user.errors[:email].any?
    password_errors = 
      user.errors[:password] + user.errors[:password_confirmation]
    errors[:password] = password_errors if password_errors.any?
    if organization.errors[:name].any?
      errors[:organization_name] = organization.errors[:name]
    end
    errors
  end
end
