class OrganizationMembershipsController < ApplicationController
  before_action :build_organization_membership, only: [:new]
  before_action :set_organization

  def create
    @user = User.where(organization_membership_params[:user]).first_or_initialize

    if @user == current_user
      redirect_to subscriber_organization_memberships_path, notice: "You just tried to invite yourself!"
    elsif @user.persisted?
      add_existing_user
    else
      invite_new_user
    end
  end

  def index
    @organization_memberships = @organization.memberships.ordered_by_user_name
    @title = "Users ~ #{@organization.display_name}"
  end

  def new
    @title = "New User ~ #{@organization.display_name}"
  end

private

  def add_existing_user
    @organization_membership = @organization.add_user(@user)
    @organization_membership.role = organization_membership_params[:role]

    if @organization_membership.save
      redirect_to subscriber_organization_memberships_path, notice: "User added successfully."
    else
      @title = "New User ~ #{@organization.display_name}"
      render :new
    end
  end

  def build_organization_membership
    @organization_membership = OrganizationMembership.new(
      organization: @organization,
      user:         User.new
    )
  end

  def invite_new_user
    render json: @user
  end

  def organization_membership_params
    params.require(:organization_membership).permit(
      :role,
      user: [:email]
    ).merge(
      organization_id: @organization.id
    )
  end

  def set_organization
    @organization = @subscriber
  end

end
