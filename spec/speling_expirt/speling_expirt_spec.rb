require File.expand_path(File.dirname(__FILE__) + "/../spec_helper")
require 'speling_expirt/speling_expirt'

describe SpelingExpirt::SpelingExpirt do

  it "should be instantiable with no parameters" do
    lambda { SpelingExpirt::SpelingExpirt.new }.should_not raise_error
  end

  before(:each) do
    @speller = SpelingExpirt::SpelingExpirt.new
  end

  it "should hold onto the word list" do
    @speller.word_list = ["spelling"]
    
    @speller.word_list.should == ["spelling"]
  end
  
  describe "new game" do
    before(:each) do
      @speller.word_list = ["foo", "bar"]
      @speller.new_game(6)
    end

    it "should be a new game" do
      @speller.start.should == true
    end

    it "should set the letters remaining" do
      @speller.letters.should == ("a".."z").to_a
    end

    it "should set the in game word list" do
      @speller.words.should == ["foo", "bar"]
    end

    it "should reset the in game word list" do
      @speller.word_list = ["foo", "bar"]
      @speller.new_game(6)
      @speller.incorrect_guess("f")
      
      @speller.new_game(6)
      
      @speller.words.should == ["foo", "bar"]
    end
  end
  
  it "should not be a new game" do
    @speller.word_list = ["foo", "bar"]
    @speller.new_game(6)
    
    @speller.guess("___", 6)

    @speller.start.should == false
  end
  
  it "should fail" do
    lambda { @speller.fail("just because") }.should_not raise_error
  end
  
  it "should receive the game result" do
    lambda { @speller.game_result("win", "spellorama") }.should_not raise_error
  end
  
  describe "in a new game" do
    before(:each) do
      @speller.word_list = ["spelling", "master"]
      @speller.new_game(6)
    end
    
    it "should filter words based on an incorrect guess" do
      @speller.incorrect_guess("a")
      
      @speller.words.should == ["spelling"]
    end
    
    it "should filter words based on a correct guess" do
      @speller.correct_guess("a")
      
      @speller.words.should == ["master"]
    end
    
    it "should remove letter remaining after a guess" do
      guessed_letter = @speller.guess("______", 6)
      
      @speller.letters.include?(guessed_letter).should == false
    end
  
    it "should filter words based on the word length" do
      @speller.guess("________", 6)
    
      @speller.words.should == ["spelling"]
    end
    
    it "should filter words based on the known letters" do
      @speller.word_list << "disaster"
      @speller.new_game(6)

      @speller.guess("d_______", 6)
      
      @speller.words.should == ["disaster"]
    end
    
    it "should count hits" do
      @speller.word_list = ["foo", "bar"]
      @speller.new_game(6)
      
      @speller.count_hits("a").should == 1
      @speller.count_hits("z").should == 0
    end
  
    it "should guess the most frequently occurring letter" do
      @speller.word_list = ["zanzibar", "zooology"]
      @speller.new_game(6)

      @speller.guess("________", 6).should == "z"
    end

  end
  
end