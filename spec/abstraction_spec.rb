require 'rubygems'
require 'spec'

$: << File.join(File.dirname(__FILE__), '..', 'lib')
require 'abstraction'

describe "#abstract" do
  class Animal
    abstract
  end
  
  class Cat < Animal; end
  
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
  
  it "lets subclasses be instantiated via allocate" do
    lambda {
      Cat.new
    }.should_not raise_error(AbstractClassError)
  end
end
