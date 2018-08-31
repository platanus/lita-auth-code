require "spec_helper"

describe Lita::Handlers::AuthCode, lita_handler: true do
  before :each do
    srand(1)
  end

  it { is_expected.to route_command("authme") }

  it "responds to user with code" do
    send_command("authme")
    expect(replies.last).to eq("228037")
  end
end
