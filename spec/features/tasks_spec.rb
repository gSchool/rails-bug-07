require 'rails_helper'
require 'capybara/rails'

feature 'Tasks' do

  scenario 'User can add a task marked as complete' do
    user = create_user email: "user@example.com"
    TaskList.create!(name: "Work List")

    login(user)
    click_on "+ Add Task", match: :first
    fill_in "Description", with: "Something important"
    two_days_from_now = 2.days.from_now.to_date
    select two_days_from_now.strftime("%Y"), from: "task_due_date_1i"
    select two_days_from_now.strftime("%B"), from: "task_due_date_2i"
    select two_days_from_now.strftime("%-d"), from: "task_due_date_3i"
    check "Completed"
    click_on "Create Task"

    expect(page).to have_content("Something important")
    expect(page).to have_content("Task was created successfully!")
    expect(page).to have_content("1 day")
    expect(page).to have_css(".task.completed")
  end

  scenario 'User can add a task marked as incomplete' do
    user = create_user email: "user@example.com"
    TaskList.create!(name: "Work List")

    login(user)
    click_on "+ Add Task", match: :first
    fill_in "Description", with: "Read a book"
    click_on "Create Task"

    expect(page).to have_content("Read a book")
    expect(page).to have_content("Task was created successfully!")
    expect(page).to_not have_css(".task.completed")
  end

end