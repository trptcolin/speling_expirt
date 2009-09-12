module SpelingExpirt
  class SpelingExpirt
    attr_reader :words
    
    def word_list
      @@words
    end
    
    def word_list=(l)
      @@words ||= l
    end
    
    def new_game(l)
      @start = true
      @ltrs = ('a'..'z').to_a
      @words = @@words.dup
    end
    
    def guess(s, l)
      trim_opening(s)
      ltr = hits_on_ltrs.sort[-1][1]
      @ltrs.delete(ltr)
      return ltr
    end
    
    def trim_opening(s)
      @start ? (@start = false) || trim_by_size(s) : trim_by_ltr(s)
    end
    
    def hits_on_ltrs
      @ltrs.dup.map { |l| [hits(l), l] }
    end
    
    def hits(ltr, hits=0)
      @words.each { |w| w.index(ltr) && hits += 1 }
      filter_ltrs_for_hits(hits, ltr)
      hits
    end
    
    def filter_ltrs_for_hits(hits, ltr)
      hits == 0 && @ltrs.delete(ltr)
    end
    
    def correct_guess(g)
       @words[1] != nil && spawn_good(g)
    end
    
    def spawn_good(g)
      Thread.new { trim_good(g) }
    end
    
    def trim_good(g)
      @words.reject! { |w| !w.index(g) }
    end
    
    def incorrect_guess(g)
      Thread.new { trim_bad(g) }
    end
    
    def trim_bad(g)
      @words.reject! { |w| w.index(g) }
    end
    
    def trim_by_size(s)
      @words.reject! { |w| w.size != s.size }
    end
    
    def trim_by_ltr(s)
      @words.reject! { |w| no_match?(s, w) }
    end
    
    def no_match?(s, w)
      i = 0
      while (i < s.size) do
        return true if bad_ltr?(s, w, i)
        i+= 1
      end
      false
    end
    
    def bad_ltr?(s, w, i)
      s[i] != 95 && s[i] != w[i]
    end
    
    def fail(r)
    end
    
    def game_result(r, w)
    end
  end
end