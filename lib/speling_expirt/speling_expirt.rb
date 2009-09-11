module SpelingExpirt
  class SpelingExpirt
    attr_reader :letters
    attr_reader :words
    attr_reader :start

    def word_list
      @@all_words
    end
    
    def word_list=(list)
      @@all_words = list
    end
    
    def new_game(left)
      @start = true
      @letters = ('a'..'z').to_a
      @words = @@all_words.dup
    end

    def guess(secret, left)
      trim_by_size(secret) if @start
      @start = false
      trim_by_letter(secret)
      guess = get_best_letter
      @letters.delete(guess)
      return guess
    end
    
    def get_best_letter
      @letters.map { |l| [count_hits(l), l] }.sort.last[1]
    end
    
    def count_hits(letter, hits = 0)
      @words.each do |w|
        # hits = add_if_hit(w, letter, hits)
        hits += 1 if w.include?(letter)
      end
      hits
    end
    
    # def add_if_hit(word, letter, hits)
    #   word.include?(letter) ? hits + 1 : hits
    # end
    
    def correct_guess(guess)
      Thread.new { @words.reject! { |w| !w.include?(guess) } }
    end
    
    def incorrect_guess(guess)
      Thread.new { @words.reject! { |w| w.include?(guess) } }
    end
    
    def trim_by_size(secret)
      @words.reject! { |w| w.size != secret.size }
    end
    
    def trim_by_letter(secret)
      @words.reject! { |w| !might_match?(secret, w) }
    end
    
    def might_match?(secret, word)
      0.upto(secret.size - 1) do |i|
        return false if bad_letter?(secret, word, i)
      end
      return true
    end
    
    def bad_letter?(secret, word, i)
      c = secret[i]
      c.chr != "_" && c != word[i]
    end
    
    def fail(reason)
    end

    def game_result(result, word)
    end
  end
end