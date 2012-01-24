require 'spec_helper'

describe "logs/new" do
  it "renders new log form to import csv file" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => csv_import_url, :method => "post" do
    end
  end
end
