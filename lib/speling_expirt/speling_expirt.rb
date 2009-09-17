module SpelingExpirt
  class SpelingExpirt
    def initialize
      @all_letters = ('a'..'z').to_a
    end

    def word_list=(l)
      set_all_words
      l = l.dup
      while (w = l.pop)
        add_word(w)
      end
    end

    def new_game(l)
      @letters = @all_letters.dup
      @words = nil
    end

    def guess(s, l)
      @words ? trim_non_matchers(s) : right_sized_words(s)
      @letters.delete(best_letter)
    end

    def correct_guess(g)
      @words.reject! { |w| !w.include?(g) }
    end

    def incorrect_guess(g)
      @words.reject! { |w| w.include?(g) }
    end

    def fail(r)
    end

    def game_result(r, w)
    end
    
    def matcher(s)
      /^#{s.gsub("_", "[#{@letters}]")}$/
    end
    
    private
    
    def add_word(w)
      @all_words_by_letter[w.size] << w
    end
    
    def set_all_words
      @all_words_by_letter = Hash.new {|h,k| h[k] = [] }
    end

    def trim_non_matchers(s)
      r = matcher(s)
      @words.reject! { |w| !(w =~ r) }
    end
    
    def right_sized_words(s)
      @words = @all_words_by_letter[s.size].dup
    end
    
    def best_letter
      @letters.dup.map{ |l| [hits(l), l] }.max[1]
    end

    def hits(ltr)
      hits = 0
      for w in @words
        w.include?(ltr) && hits += 1
      end
      hits == 0 && @letters.delete(ltr)
      hits
    end
    
  end
end