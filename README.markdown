Abstract Classes.  In Ruby.
===========================

Let's say you've got a class called `Car`.  There are two subclasses of `Car`: `Convertible` and `Sedan`.  And it turns out that all cars are either convertibles or sedans.  (Who knew?)  So really, there's no reason that a car object wouldn't be an instance of `Convertible` or `Sedan`, and in fact an object that's a direct instance of `Car` itself won't even work correctly.

    class Car
      def go_forward
        # ...
      end
    end

    class Convertible < Car
      def door_count
        2
      end
    end

    class Sedan < Car
      def door_count
        4
      end
    end

How would you write `Car#doors`?  You wouldn't, because unlike moving forward, that behavior isn't shared across all cars.  `Car` is an abstract class: a class that should never be instantiated directly.

But what's stopping us?  Nothing.  And that's a problem.  So let's fix it:

    $ sudo gem install abstraction

Then:

    require 'abstraction'
    
    class Car
      abstract
      
      def go_forward
        # ...
      end
    end
    
    Car.new
    #> AbstractClassError: Car is an abstract class and cannot be instantiated

But:

    Convertible.new  # => #<Convertible:0x8fdf4>

Awesome.


Awesome?  Why so awesome?
-------------------------

Ok, let's take it back a step.  You've got a `Car` class with no subclasses.  They haven't been necessary, and you don't want to add complexity you don't need.  Good for you.

    class Car
      def go_forward
        # ...
      end
    end

Cars go forward, and that's about it.  Except, now some parts of the code want to know how many doors a car has.  Remember, that depends on the kind of car it is, so we'll need `Car` to know about its type.  And since convertibles are pretty rare in your code, you have cars be sedans by default.

    class Car
      attr_reader :type
      
      def initialize(type=:sedan)
        @type = type
      end
      
      def door_count
        case type
        when :convertible
          2
        when :sedan
          4
        end
      end
      
      def go_forward
        # ...
      end
    end

Pretty soon you realize its time to refactor this puppy.  You want a refactoring called [Replace Type Code with Subclasses](http://www.refactoring.com/catalog/replaceTypeCodeWithSubclasses.html "Refactoring: Replace Type Code with Subclasses").  What you end up with is the set of classes we saw at the beginning:

    class Car
      def go_forward
        # ...
      end
    end

    class Convertible < Car
      def door_count
        2
      end
    end

    class Sedan < Car
      def door_count
        4
      end
    end

**The problem** is that all of your tests are passing, but none of your code is using the subclasses yet.  You could probably grep or ack through your source to find all of the times you use `Car.new`; in fact, you should.  But you should still be *testing* that you've done it right.  Also, if `Car` is backed by an ORM, *it* might be creating `Car` objects for you.

But as we've seen, Abstraction clears that all up.  Just make the class abstract...

    class Car
      abstract
      
      def go_forward
        # ...
      end
    end

...and watch your tests fail.  When they pass again, you've completed the refactoring.


Abstract Methods
================

*(Warning: this section is a bit of a tease.)*

Traditionally, abstract classes are found in strongly typed languages, where the compiler makes sure they're never created by type checking.  In the Ruby world, the test suite is essentially our type checker.  No complier can statically prove that an abstract Ruby class will never be instantiated, but we can exercise the test suite and see if it ever happens.

Abstract classes usually have a way to notate abstract methods.  These are methods which are declared in the superclass, but don't have an implementation there.  A concrete subclass has to implement all of the abstract methods.  Again, this is checked by the type checker.

We have an example of an abstract method above, it's just not denoted in any way: `#door_count`.  Similar to the case of abstract classes, we can't prove statically that abstract methods are implemented in the concrete subclasses.  We have to run the tests and see if they're defined when they're called.

**But**: if they're called and there's no implementation, we'll get a `NoMethodError` anyway.  The declaration of an abstract method in the superclass is really only useful to the type checker, to tell it that, for instance, any `Car` object has a `#door_count` method.  We don't have a type checker.  So we don't need to declare abstract methods.


But wouldn't it be useful?
--------------------------

It would be, if it were meaningful.  The problem is: what does it mean to implement a method?  In Ruby you really can't know whether a method is implemented until you send it the message and see if it raises a `NoMethodError`.  There's no way to determine whether a class "implements" all of its superclasses abstract methods without making assumptions like that the class doesn't use `method_missing` or that instances of the class won't get their own singleton implementations.  And the nail in the coffin: there's no time when a Ruby class is done being implemented, so there's no time to check.

On the other hand, maybe there's a way to make it useful.  If there is, it certainly belongs here, so drop me a line or just fork away.


Credits
=======
Written by Peter Jaros at drop.io.  
Copyright 2009 drop.io, Inc.
