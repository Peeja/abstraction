require 'rubygems'
require 'spec'

$: << File.join(File.dirname(__FILE__), '..', 'lib')
require 'abstraction'

describe "#abstract" do
  # Similar to ActiveRecord::Base.new
  class Organism
    def self.new(&b)
      o = super
      yield o if block_given?
      o
    end
  end
  
  class Animal < Organism
    abstract
  end
  
  class Cat < Animal
    attr_accessor :fur
  end
  
  it "makes a class non-instantiable via new" do
    lambda {
      Animal.new
    }.should raise_error(AbstractClassError, "Animal is an abstract class and cannot be instantiated")
  end
  
  it "makes a class non-instantiable via allocate" do
    lambda {
      Animal.allocate
    }.should raise_error(AbstractClassError, "Animal is an abstract class and cannot be instantiated")
  end
  
  it "lets subclasses be instantiated via new" do
    lambda {
      Cat.new
    }.should_not raise_error(AbstractClassError)
  end
  
  it "lets subclasses be instantiated via new with a block" do
    cat = nil
    lambda {
      cat = Cat.new { |c| c.fur = :tabby }
    }.should_not raise_error(AbstractClassError)
    cat.fur.should == :tabby
  end
  
  it "lets subclasses be instantiated via allocate" do
    lambda {
      Cat.new
    }.should_not raise_error(AbstractClassError)
  end
end
