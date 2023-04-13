require 'rails_helper'

RSpec.describe Project, type: :model do
  describe "validations" do
    it "is valid with a name and description" do
      project = Project.new(name: "Example Project", description: "This is an example project.")
      expect(project).to be_valid
    end
    
    it "is invalid without a description" do
      project = Project.new(name: "Example Project")
      expect(project).to be_invalid
      expect(project.errors[:description]).to include("can't be blank")
    end
    
    it "is valid to update with a description" do
      project = Project.create(name: "Example Project", description: "This is an example project.")
      project.update(description: "This is an updated description.")
      expect(project).to be_valid
    end
    
    it "is invalid to update without a description" do
      project = Project.create(name: "Example Project", description: "This is an example project.")
      project.update(description: nil)
      expect(project).to be_invalid
      expect(project.errors[:description]).to include("can't be blank")
    end
  end
end


