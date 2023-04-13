require 'rails_helper'

RSpec.describe "items/new", type: :view do
  before(:each) do
    assign(:item, Item.new(
      title: "MyString",
      description: "MyText",
      rating: 1
    ))
  end

  it "renders new item form" do
    render

    assert_select "form[action=?][method=?]", items_path, "post" do

      assert_select "input[name=?]", "item[title]"

      assert_select "textarea[name=?]", "item[description]"

      assert_select "input[name=?]", "item[rating]"
    end
  end
end
