class AchievementsController < ApplicationController
  before_action :authenticate_user!, only: [ :new, :create, :edit, :update, :destroy ]

  def index
    @achievements = Achievement.public_access
  end

  def new
    @achievement = Achievement.new
  end

  def create
    @achievement = Achievement.new(achievement_params)

    if @achievement.save
      redirect_to achievement_path(@achievement), notice: 'Achievement has been created'
    else
      render :new, notice: 'Achievement has not been created'
    end
  end

  def show
    @achievement = Achievement.find(params.fetch(:id))
  end

  def edit
    @achievement = Achievement.find(params.fetch(:id))
  end

  def update
    @achievement = Achievement.find(params.fetch(:id))

    if @achievement.update_attributes(achievement_params)
      redirect_to achievement_path(@achievement.id), notice: 'Achievement has been updated'
    else
      render :edit, notice: 'Achievement has not been updated'
    end
  end

  def destroy
    Achievement.destroy(params.fetch(:id))
    redirect_to achievements_path, notice: 'Achievement has been deleted'
  end

  private
  def achievement_params
    params.require(:achievement).permit(:title, :description, :privacy, :cover_image, :feature)
  end
end