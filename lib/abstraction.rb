class AbstractClassError < StandardError; end

# metaid
class Object
  # The hidden singleton lurks behind everyone
  def metaclass; class << self; self; end; end
  def meta_eval &blk; metaclass.instance_eval &blk; end
  
  # Adds methods to a metaclass
  def meta_def name, &blk
    meta_eval { define_method name, &blk }
  end
  
  # Defines an instance method within a class
  def class_def name, &blk
    class_eval { define_method name, &blk }
  end
end

class Class
  def abstract
    abstract_class = self
    
    raise_if_abstract = lambda do |*args, &block|
      if self == abstract_class
        raise AbstractClassError, "#{self} is an abstract class and cannot be instantiated"
      else
        super *args, &block
      end
    end
    
    meta_def :new, &raise_if_abstract
    meta_def :allocate, &raise_if_abstract
    
    nil
  end
end
