require 'rails_helper'
require_relative '../support/login_form'
require_relative '../support/new_achievement_form'

feature 'create new achievement' do
  let(:new_achievement_form) { NewAchievementForm.new }
  let(:login_form) { LoginForm.new }
  let(:user) { FactoryGirl.create(:user) }

  background do # before
    login_form.visit_page.login_as(user)
    ActionMailer::Base.deliveries.clear
  end

  scenario 'create new achievement with validate data' do
    new_achievement_form.visit_page
                        .fill_in_with(
                          title: 'Read a book',
                            cover_image: 'cover_image.png'
                        )
                        .submit

    expect(ActionMailer::Base.deliveries.count).to eq(1)
    expect(ActionMailer::Base.deliveries.last.to).to include(user.email)

    expect(Achievement.last.cover_image_identifier).to eq('cover_image.png')

    expect(page).to have_content('Achievement has been created')
    expect(Achievement.last.title).to eq('Read a book')
  end

  scenario 'can not create new achievement with invalid data' do
    new_achievement_form.visit_page.submit
  end
end