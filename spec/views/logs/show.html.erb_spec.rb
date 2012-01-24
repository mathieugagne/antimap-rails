require 'spec_helper'

describe "logs/show" do
  before(:each) do
    @log = Factory(:log)
  end

  it "renders attributes in <p>" do
    render
  end
end
