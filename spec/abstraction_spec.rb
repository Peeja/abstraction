require 'rubygems'
require 'spec'

$: << File.join(File.dirname(__FILE__), '..', 'lib')
require 'abstraction'

describe "#abstract" do
  it "makes a class non-instantiable" do
    class Animal
      abstract
    end
    
    lambda {
      Animal.new
    }.should raise_error(AbstractClassError, "Animal is an abstract class and cannot be instantiated")
  end
  
  it "lets subclasses be instantiated" do
    class Animal
      abstract
    end
    
    class Cat < Animal; end
    
    lambda {
      Cat.new
    }.should_not raise_error(AbstractClassError)
  end
end
