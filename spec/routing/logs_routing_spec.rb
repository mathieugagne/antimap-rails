require "spec_helper"

describe LogsController do
  describe "routing" do

    it "routes to #index" do
      get("/logs").should route_to("logs#index")
    end

    it "routes to #new" do
      get("/logs/new").should route_to("logs#new")
    end

    it "routes to #show" do
      get("/logs/1").should route_to("logs#show", :id => "1")
    end

    it "routes to #destroy" do
      delete("/logs/1").should route_to("logs#destroy", :id => "1")
    end

  end
end
