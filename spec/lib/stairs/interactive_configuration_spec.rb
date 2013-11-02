require "spec_helper"

describe Stairs::InteractiveConfiguration do
  subject { described_class.new }

  describe "metadata" do
    it "has a title" do
      expect(described_class.step_title).not_to be_nil
    end

    it "has a description" do
      expect(described_class.step_description).not_to be_nil
    end
  end

  describe "#run!" do
    before do
      Stairs::EnvAdapters.stub recommended_adapter: Stairs::EnvAdapters::Rbenv
    end

    it "recommends an adapter" do
      output = follow_prompts("Y") { subject.run! }
      expect(output).to include "you're using rbenv"
    end

    it "sets the adapter" do
      follow_prompts("Y") { subject.run! }
      expect(Stairs.configuration.env_adapter).to be_a Stairs::EnvAdapters::Rbenv
    end

    it "allows for specifying your desired adapter" do
      follow_prompts("N", "dotenv") { subject.run! }
      expect(Stairs.configuration.env_adapter).to be_a Stairs::EnvAdapters::Dotenv
    end
  end
end