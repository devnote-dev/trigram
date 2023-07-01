require "spec"
require "../src/trigram"

describe Trigram do
  it "parses simple strings" do
    Trigram.parse("Cod").should eq [4419428]
    Trigram.parse("Code").should eq [4419428, 7300197]
  end

  it "parses basic queries" do
    trigram = Trigram.new do |t|
      t.add "Code is my life"
      t.add "Search"
      t.add "I write a lot of Codes"
    end

    res = trigram.query "Code"
    res.size.should eq 2
    res.should eq [1, 3]
  end

  it "parses empty or small strings" do
    trigram = Trigram.new do |t|
      t.add "Code is my life"
      t.add "Search"
      t.add "I write a lot of Codes"
    end

    res = trigram.query "te"
    res.size.should eq 3
    res.should eq [1, 2, 3]

    res = trigram.query ""
    res.size.should eq 3
    res.should eq [1, 2, 3]
  end

  it "deletes an index" do
    trigram = Trigram.new &.add "Code is my life"

    trigram.delete "Code", 1
    trigram.query("Code").should be_empty

    res = trigram.query "life"
    res.size.should eq 1
    res.should eq [1]
  end
end
