require "spec_helper"

describe Lita::Handlers::AuthCode, lita_handler: true do
  let(:robot) { Lita::Robot.new(registry) }
  subject { described_class.new(robot) }

  it { is_expected.to route_command("authme") }

  it "responds to user with code" do
    allow_any_instance_of(described_class).to receive(:generate_pin).and_return("123456")
    send_command("authme")
    expect(replies.last).to eq("123456")
  end

  it "generates a new code if it's already used" do
    subject.redis.set("123456", "pedro")
    allow_any_instance_of(described_class).to receive(:generate_pin).and_return("123456", "234567")

    send_command("authme")
    expect(replies.last).to eq("234567")
  end
end
