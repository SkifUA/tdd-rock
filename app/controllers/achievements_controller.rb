class AchievementsController < ApplicationController
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

  private
  def achievement_params
    params.require(:achievement).permit(:title, :description, :privacy, :cover_image, :feature)
  end
end