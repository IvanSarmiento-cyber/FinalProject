require "rails_helper"

RSpec.feature "Projects", type: :feature do
  context "Create project" do
    scenario "user creates a project with a title and description" do
      visit new_project_path

      fill_in "Title", with: "New Project"
      fill_in "Description", with: "This is a new project"
      click_button "Create Project"

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

  context "Update project" do
    let(:project) { Project.create(title: "Test title", description: "Test content") }

    before(:each) do
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
      expect(page).to have_content("Title can't be blank")
    end
  end
end
