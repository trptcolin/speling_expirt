$: << File.dirname(__FILE__)

require 'hangman/hangman_engine'
require 'hangman/mock_ui'
require 'speling_expirt/speling_expirt'

engine = Hangman::HangmanEngine.new(Hangman::MockUi.new, 1)
puts engine.play_games([SpelingExpirt::SpelingExpirt.new], 1000).inspect