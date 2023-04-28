require "rails_helper"

RSpec.describe ProjectsController, :type => :controller do
    describe "test web requests" do
        context "GET #index" do
            it "returns a success response" do
            get :index
            expect(response).to have_http_status(:ok)
            end
        end

        context "GET #show" do
  let!(:project) { Project.create(title: "Test title", description: "Test description") }
  it "returns a success response" do
    get :show, params: { id: project.id }
    expect(response).to have_http_status(:ok)
  end
end


        context "POST #create" do
            it "creates a new project and redirects to index" do
                post :create, params: { project: { title: "New project", description: "New project description" } }
                expect(Project.count).to eq(1)
                expect(response).to redirect_to(projects_path)
            end
        end
    end
end
