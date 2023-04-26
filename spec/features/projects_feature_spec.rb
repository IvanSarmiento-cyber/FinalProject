require "rails_helper"

RSpec.feature "Projects", type: :feature do
  context "Create project" do
    before(:each) do
      user = FactoryBot.create(:user)
      login_as(user)
      visit new_project_path
    end
     
    scenario "user creates a project with a title and description" do
      visit new_project_path

      fill_in "Title", with: "New Project"
      fill_in "Description", with: "This is a new project"
      click_button "Create Project"
      expect(page).to have_current_path(project_path(Project.last))

      expect(page).to have_content("Project was successfully created.")
    end

    scenario "user creates a project without a title" do
      visit new_project_path

      fill_in "Description", with: "This is a new project"
      click_button "Create Project"

      expect(page).to have_content("Title can't be blank")
    end

    scenario "user creates a project without a description" do
      visit new_project_path

      fill_in "Title", with: "New Project"
      click_button "Create Project"

      expect(page).to have_content("Description can't be blank")
    end

    scenario "user creates a project without a title and description" do
      visit new_project_path

      click_button "Create Project"

      expect(page).to have_content("Title can't be blank")
      expect(page).to have_content("Description can't be blank")
    end
  end
  
  context "Authentication" do
    scenario "user signs up" do
      visit root_path
      click_link 'Sign up'
      within("form") do
        fill_in "Email", with: "testing@test.com"
        fill_in "Password", with: "123456"
        fill_in "Password confirmation", with: "123456"
        click_button "Sign up"
      end
      expect(page).to have_current_path(root_path)
      expect(page).to have_content("Welcome! You have signed up successfully.")
    end

    scenario "user logs in" do
      user = FactoryBot.create(:user)
      login_as(user, scope: :user)
      visit root_path
      expect(page).to have_content("Logged in")
    end
  end

  context "Update project" do
    let(:project) { FactoryBot.create(:project, title: "Test title", description: "Test content") }

    before(:each) do
      user = FactoryBot.create(:user)
      login_as(user)
      visit edit_project_path(project)
    end
      
    scenario "should be successful" do
      within("form") do
        fill_in "Description", with: "New description content"
      end
      click_button "Update Project"
      expect(page).to have_content("Project was successfully updated")
    end

    scenario "should fail if description is blank" do
      within("form") do
        fill_in "Description", with: ""
      end
      click_button "Update Project"
      expect(page).to have_content("Description can't be blank")
    end
    
    scenario "should fail if title is blank" do
      within("form") do
        fill_in "Title", with: ""
      end
      click_button "Update Project"
      expect(page).to have_current_path(project_path(project))
      expect(page).to have_content("Title can't be blank")
    end
  end
end