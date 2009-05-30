class AbstractClassError < StandardError; end

class Class
  def abstract
    @abstract_class = true
    
    self.extend Module.new {
      def new(*args, &block)
        if @abstract_class
          raise AbstractClassError, "#{self} is an abstract class and cannot be instantiated"
        else
          super *args, &block
        end
      end
      
      def allocate(*args, &block)
        if @abstract_class
          raise AbstractClassError, "#{self} is an abstract class and cannot be instantiated"
        else
          super *args, &block
        end
      end
    }
    
    nil
  end
end
