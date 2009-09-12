require File.expand_path(File.dirname(__FILE__) + "/../spec_helper")
require 'speling_expirt/speling_expirt'

describe SpelingExpirt::SpelingExpirt do

  it "should be instantiable with no parameters" do
    lambda { SpelingExpirt::SpelingExpirt.new }.should_not raise_error
  end
  
  before(:each) do
    @speller = SpelingExpirt::SpelingExpirt.new
    @speller.word_list = ["foo", "bar", "spelling", "master"]
  end

  it "should hold onto the word list" do
    @speller.word_list.should == ["foo", "bar", "spelling", "master"]
  end
  
  describe "new game" do
    before(:each) do
      @speller.new_game(6)
    end

    it "should set the in game word list" do
      @speller.words.should == @speller.word_list
    end

    it "should reset the in game word list" do
      @speller.new_game(6)
      @speller.incorrect_guess("f")
      
      @speller.new_game(6)
      
      @speller.words.should == @speller.word_list
    end
  end
  
  it "should fail" do
    lambda { @speller.fail("just because") }.should_not raise_error
  end
  
  it "should receive the game result" do
    lambda { @speller.game_result("win", "spellorama") }.should_not raise_error
  end
  
  describe "in a new game" do
    before(:each) do
      @speller.new_game(6)
    end
    
    it "should filter words based on an incorrect guess" do
      @speller.incorrect_guess("a")
      
      @speller.words.should == ["foo", "spelling"]
    end
    
    it "should filter words based on a correct guess" do
      @speller.correct_guess("a")
      
      @speller.words.should == ["bar", "master"]
    end
  
    it "should filter words based on the word length" do
      @speller.guess("________", 6)
    
      @speller.words.should == ["spelling"]
    end
    
    it "should filter words based on the known ltrs" do
      @speller.words << "disaster"
      @speller.words << "deluging"
      @speller.guess("________", 6)

      @speller.guess("d_______", 6)
      
      @speller.words.should == ["disaster", "deluging"]
    end
    
    it "should count hits" do
      @speller.new_game(6)
      
      @speller.hits("a").should == 2
      @speller.hits("z").should == 0
    end
  
    it "should guess the most frequently occurring ltr" do
      @speller.new_game(6)
      @speller.words << "zanzibar"
      @speller.words << "zooology"
      @speller.words << "zephyryu"
    
      @speller.guess("________", 6).should == "z"
    end
    
    it "should guess twice" do
      @speller.new_game(6)
      @speller.guess("________", 6)
      @speller.guess("________", 6).should == "p"
    end
  end
end