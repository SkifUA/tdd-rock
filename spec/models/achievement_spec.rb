require 'rails_helper'

RSpec.describe Achievement, type: :model do
  describe "validation" do
    it "requires title" do
      achievement = Achievement.new(title: '')
      expect(achievement.valid?).to be_falsy
    end

    it "requires title to be unique for one user" do
      user = FactoryGirl.create(:user)
      factory_achievement = FactoryGirl.create(:public_achievement, title:'First Achievement', user: user)
      new_achievement = Achievement.new(title: 'First Achievement', user: user)
      expect(new_achievement.valid?).to be_falsy
    end

    it "allow different user to have with identical achievements" do
      user1 = FactoryGirl.create(:user)
      user2 = FactoryGirl.create(:user)
      first_achievement = FactoryGirl.create(:public_achievement, title:'First Achievement', user: user1)
      new_achievement = Achievement.new(title:'First Achievement', user: user2)
      expect(new_achievement.valid?).to be_truthy
    end
  end
end
