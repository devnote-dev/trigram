require "spec"
require "../src/trigram"

describe Trigram do
  it "parses simple strings" do
    Trigram.parse("Cod").should eq [4419428]
  end
end
