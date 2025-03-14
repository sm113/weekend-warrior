class OrganizationsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_organization, only: [:show, :edit, :update, :destroy]
  before_action :check_owner, only: [:edit, :update, :destroy]

  def index
    @organizations = current_user.organizations if user_signed_in?
    @organizations ||= []
  end

  def show
  end

  def new
    @organization = Organization.new
  end

  def create
    @organization = current_user.organizations.build(organization_params)
    
    if @organization.save
      redirect_to @organization, notice: 'Organization was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @organization.update(organization_params)
      redirect_to @organization, notice: 'Organization was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @organization.destroy
    redirect_to organizations_path, notice: 'Organization was successfully deleted.'
  end

  private

  def set_organization
    @organization = Organization.find(params[:id])
  end

  def check_owner
    unless @organization.user == current_user
      redirect_to organizations_path, alert: 'You are not authorized to perform this action.'
    end
  end

  def organization_params
    params.require(:organization).permit(:name, :description, :logo)
  end
end
