require File.expand_path(File.dirname(__FILE__) + "/../spec_helper")
require 'speling_expirt/speling_expirt'

class TestableSpelingExpirt < SpelingExpirt::SpelingExpirt
  attr_reader :words, :letters, :all_letters, :all_words_by_letter
end

describe SpelingExpirt::SpelingExpirt do

  before(:each) do
    @speller = TestableSpelingExpirt.new
  end
   
  it "should start with all the letters" do
    @speller.all_letters.should == ("a".."z").to_a
  end
  
  it "should create word hash with default values" do
  end
  
  it "should assign the word list" do
    @speller.word_list = ["foo", "bar", "test"]
    
    @speller.all_words_by_letter[3].sort.should == ["bar", "foo"]
    @speller.all_words_by_letter[4].should == ["test"]
    @speller.all_words_by_letter.keys.sort.should == [3, 4]

    @speller.all_words_by_letter[:foo].should == []
    @speller.all_words_by_letter[:foo] << "test"
    @speller.all_words_by_letter[:foo].should == ["test"]
  end
  
  it "should start a new game" do
    @speller.word_list = []
    @speller.new_game(6)
    
    @speller.letters.should == ("a".."z").to_a
    @speller.words.should == nil

    @speller.guess("___", 1)
    @speller.all_letters.should == ("a".."z").to_a
  end
  
  it "should limit to properly-sized words on the first guess" do
    @speller.word_list = ["foo", "bar", "test"]
    @speller.new_game(1)
    @speller.guess("___", 1)
    
    @speller.words.sort.should == ["bar", "foo"]
    
    @speller.new_game(1)
    @speller.guess("____", 1)
    
    @speller.words.should == ["test"]
  end
  
  it "should trim non-matching words on the second guess" do
    @speller.word_list = ["foo", "bar", "buz"]
    @speller.new_game(1)
    
    guesses = []
    @speller.guess("___", 1).should == "b"
    @speller.words.sort.should == ["bar", "buz", "foo"]
    @speller.guess("b__", 1)

    @speller.words.sort.should == ["bar", "buz"]
  end
  
  it "should guess most frequently occurring letter and trim hitless ones" do
    @speller.word_list = ["abc", "ade"]
    @speller.new_game(1)

    @speller.guess("___", 1).should == "a"
    
    @speller.letters.should == ["b", "c", "d", "e"]
  end
  
  it "should trim words based on correct guess" do
    @speller.word_list = ["foo", "bar"]
    @speller.new_game(1)
    @speller.guess("___", 1)
    
    @speller.correct_guess("o")

    @speller.words.should == ["foo"]
  end

  it "should trim words based on an incorrect guess" do
    @speller.word_list = ["foo", "bar"]
    @speller.new_game(1)
    @speller.guess("___", 1)
    
    @speller.incorrect_guess("o")
    
    @speller.words.should == ["bar"]
  end
  
  it "should fail" do
    lambda { @speller.fail("just because") }.should_not raise_error
  end
  
  it "should receive the game result" do
    lambda { @speller.game_result("win", "spellorama") }.should_not raise_error
  end
  
  it "should build a regexp based on the letters left and the secret word" do
    @speller.word_list = ["abb", "acc"]
    @speller.new_game(1)
    
    @speller.guess("___", 1).should == "a"
    
    @speller.letters.should == ["b", "c"]
    
    @speller.matcher("a__").should == /^a[bc][bc]$/
  end
end