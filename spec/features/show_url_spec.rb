require_relative '../spec_helper'

RSpec.describe "When a valid user views URL data" do
  it "Shows client name" do
    new_client
    new_payload
    visit("/sources/google/urls/about")
    within("#client_name_url") do
      expect(page).to have_content("Client: google")
    end
  end

  it "Shows url" do
    new_client
    new_payload
    visit("/sources/google/urls/about")
    within("#url") do
      expect(page).to have_content("URL: about")
    end
  end
end
