module Hangman
  class MockUi
    def set_delay(delay)
    end
    
    def guessed(guess)
    end
  
    def update_word(word)
    end
  
    def new_game(player, guesses_left)
    end
  
    def correct_guess(guess)
    end
  
    def incorrect_guess(guess)
    end
  
    def update_word(filtered_word)
    end
  
    def fail(reason)
    end
  
    def game_result(result, word)
    end
  
    def game_score(score)
    end
  end
end