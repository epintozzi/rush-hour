require_relative '../spec_helper'

RSpec.describe "When a valid user views their data" do
  it "Shows client page" do
    new_client
    new_payload
    visit("/sources/google")
    within("#client_name") do
      expect(page).to have_content("Client: ")
    end
  end
end
