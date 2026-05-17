class Api::V1::SignupsController < ApplicationController
  # Creates organization AND its owner's / first user's account
  def create
    organization = Organization.new(name: signup_params[:organization_name])
    user = organization.users.build(
      email: signup_params[:email],
      password: signup_params[:password],
      password_confirmation: signup_params[:password_confirmation],
      role: :admin,
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

  def signup_errors(organization, user)
    errors = {}
    errors[:email] = user.errors[:email] if user.errors[:email].any?
    # Devise mentions errors related to :password_confirmation within :password
    errors[:password] = user.errors[:password] if user.errors[:password].any?
    if organization.errors[:name].any?
      errors[:organization_name] = organization.errors[:name]
    end
    errors
  end
end
