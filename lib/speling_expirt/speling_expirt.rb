module SpelingExpirt
  class SpelingExpirt
    attr_accessor :words

    def word_list
      @@all_words
    end
    
    def word_list=(list)
      @@all_words ||= list
    end
    
    def new_game(left)
      @start = true
      @ltrs = ('a'..'z').to_a
      @words = @@all_words.dup
    end

    def guess(secret, left)
      trim_opening(secret)
      ltr = hits_on_ltrs.sort[-1][1]
      @ltrs.delete(ltr)
      return ltr
    end
    
    def trim_opening(secret)
      @start ? (@start = false) || trim_by_size(secret) : trim_by_ltr(secret)
    end
    
    def hits_on_ltrs
      @ltrs.dup.map { |l| [hits(l), l] }
    end
    
    def hits(ltr, hits = 0)
      @words.each { |w| w.index(ltr) && hits += 1 }
      filter_ltrs_for_hits(hits, ltr)
      hits
    end
    
    def filter_ltrs_for_hits(hits, ltr)
      hits == 0 && @ltrs.delete(ltr)
    end
    
    def correct_guess(guess)
       @words[1] != nil && spawn_for_good(guess)
    end
    
    def spawn_for_good(guess)
      Thread.new { trim_good(guess) }
    end
    
    def trim_good(guess)
      @words.reject! { |w| !w.index(guess) }
    end
    
    def incorrect_guess(guess)
      Thread.new { trim_bad(guess) }
    end
    
    def trim_bad(guess)
      @words.reject! { |w| w.index(guess) }
    end
    
    def trim_by_size(secret)
      @words.reject! { |w| w.size != secret.size }
    end
    
    def trim_by_ltr(secret)
      @words.reject! { |w| no_match?(secret, w) }
    end
    
    def no_match?(secret, w)
      i = 0
      while (i < secret.size) do
        return true if bad_ltr?(secret, w, i)
        i+= 1
      end
      false
    end
    
    def bad_ltr?(secret, word, i)
      secret[i] != 95 && secret[i] != word[i]
    end
    
    def fail(reason)
    end

    def game_result(result, word)
    end
  end
end