require "rails_helper"

RSpec.describe ErrorMessage do
  it "exists" do
    error_message = ErrorMessage.new("hello", "404")

    expect(error_message).to be_a ErrorMessage
    expect(error_message.message).to eq("hello")
    expect(error_message.status_code).to eq("404")
  end
end