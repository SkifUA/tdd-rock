require 'rails_helper'
require_relative '../support/new_achievement_form'

feature 'create new achievement' do
  let(:new_achievement_form) { NewAchievementForm.new }
  scenario 'create new achievement with validate data' do
    new_achievement_form.visit_page
                        .fill_in_with(
                          title: 'Read a book'
                        )
                        .submit

    expect(page).to have_content('Achievement has been created')
    expect(Achievement.last.title).to eq('Read a book')
  end

  scenario 'can not create new achievement with invalid data' do
    new_achievement_form.visit_page.submit
  end
end