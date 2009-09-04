require 'rake'
require 'rake/gempackagetask'
require 'spec/rake/spectask'
require 'hangman_tournament/submit'

desc "Run all specs"
Spec::Rake::SpecTask.new('spec') do |t|
  t.spec_files = FileList['spec/**/*.rb']
  t.rcov = false
end

PKG_NAME = "speling_expirt"
PKG_VERSION   = "1.0"

spec = Gem::Specification.new do |s|
  s.name = "hangman_#{PKG_NAME}"
  s.version = PKG_VERSION
  s.files = Dir.glob('**/*').reject{ |f| f =~ /pkg/ }
  s.require_path = 'lib'
  s.test_files = Dir.glob('spec/*_spec.rb')
  s.bindir = 'bin'
  s.executables = []
  s.summary = "Hangman Player:Speling Expirt"
  s.rubyforge_project = "sparring"
  s.homepage = "http://sparring.rubyforge.org/"

  ###########################################
  ##
  ## You are encouraged to modify the following
  ## spec attributes.
  ##
  ###########################################
  s.description = "Don't hate the player."
  s.author = "Colin Jones"
  s.email = "colin@8thlight.com"
end

Rake::GemPackageTask.new(spec) do |pkg|
  pkg.need_zip = false
  pkg.need_tar = false
end

desc "Submit your player"
task :submit do
  submitter = HangmanTournament::Submit.new(PKG_NAME)
  submitter.submit
end
