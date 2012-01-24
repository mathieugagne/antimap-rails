require 'spec_helper'

describe "logs/index" do
  before(:each) do
    assign(:logs, [
      Factory(:log),
      Factory(:log)
    ])
  end

  it "renders a list of logs" do
    render
  end
end
