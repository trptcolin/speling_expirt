module SpelingExpirt
  class SpelingExpirt
    attr_reader :words
    
    def word_list
      @@words
    end
    
    def word_list=(l)
      @@words ||= l
      @words ||= []
    end
    
    def new_game(l)
      @start = true
      @ltrs = ('a'..'z').to_a
      @words.replace(@@words)
    end
    
    def guess(s, l)
      trim_opening(s)
      @ltrs.delete(@ltrs.sort_by{|l| hits(l)}.last)
    end
    
    def correct_guess(g)
      @words.reject! { |w| !w.include?(g) }
      @words.size == 1 && @ltrs.reject! { |l| !@words[0].include?(l) }
    end
    
    def incorrect_guess(g)
      @words.reject! { |w| w.include?(g) }
    end
    
    def fail(r)
    end
    
    def game_result(r, w)
    end
    
    private
    def trim_opening(s)
      @start ? ((@start = false) || trim_by_size(s)) : trim_by_ltr(s)
    end
    
    def hits(ltr, hits=0)
      for w in @words
        w.include?(ltr) && hits += 1
      end
      hits
    end
    
    def trim_by_size(s, size = s.size)
      @words.reject! { |w| w.size != size }
    end
    
    def trim_by_ltr(s, size = s.size)
      @words.reject! { |w| no_match?(s, w, size) }
    end
    
    def no_match?(s, w, size)
      0.upto(size - 1) do |i|
        return true if bad_ltr?(s, w, i)
      end
      false
    end
    
    def bad_ltr?(s, w, i, c = s[i])
      c != 95 && c != w[i]
    end
  end
end