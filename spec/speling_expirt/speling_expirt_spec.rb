require File.expand_path(File.dirname(__FILE__) + "/../spec_helper")
require 'speling_expirt/speling_expirt'

describe SpelingExpirt::SpelingExpirt do

  it "should be instantiable with no paramters" do

    lambda { SpelingExpirt::SpelingExpirt.new }.should_not raise_error

  end

end