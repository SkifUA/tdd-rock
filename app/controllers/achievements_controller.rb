class AchievementsController < ApplicationController
  before_action :authenticate_user!, only: [ :new, :create, :edit, :update, :destroy ]
  before_action :get_achievement, only: [ :show, :edit, :update, :destroy ]
  before_action :owners_only, only: [ :edit, :update, :destroy ]

  def index
    @achievements = Achievement.public_access
  end

  def new
    @achievement = Achievement.new
  end

  def create
    @achievement = Achievement.new(achievement_params)
    @achievement.user_id = current_user.id

    if @achievement.save
      UserMailer.achievement_created(current_user.email, @achievement.id).deliver_now
      redirect_to achievement_path(@achievement), notice: 'Achievement has been created'
    else
      render :new, notice: 'Achievement has not been created'
    end
  end

  def show
  end

  def edit
  end

  def update
    if @achievement.update_attributes(achievement_params)
      redirect_to achievement_path(@achievement.id), notice: 'Achievement has been updated'
    else
      render :edit, notice: 'Achievement has not been updated'
    end
  end

  def destroy
    @achievement.destroy
    redirect_to achievements_path, notice: 'Achievement has been deleted'
  end

  private
  def achievement_params
    params.require(:achievement).permit(:title, :description, :privacy, :cover_image, :feature)
  end

  def get_achievement
    @achievement = Achievement.find(params.fetch(:id))
  end

  def owners_only
    if current_user != @achievement.user
      redirect_to achievements_path
    end
  end
end