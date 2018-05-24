#!/usr/bin/ruby19
# encoding: utf-8

require 'test/unit'

$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib')).uniq!
require 'kinda-core'

class ModuleTest < Test::Unit::TestCase
  def meth
    'meth'
  end
  
  def meth_with_upcase
    meth_without_upcase.upcase
  end
  
  alias_method_chain :meth, :upcase
  
  def test_alias_method_chain
    assert_equal 'METH', meth
  end
  
  $meth2 = []
  
  module A
    module ClassMethods1  
      def meth1
        'meth1'
      end
    end

    module ClassMethods2
      def meth2
        $meth2 << 'ClassMethods2.meth2'
      end
    end

    inheritable_extend ClassMethods1, ClassMethods2
  end

  module B
    include A

    ClassMethods3 = inheritable_extend do
      $meth1 = meth1

      def meth3
        'meth3'
      end
    end

    module ClassMethods4
      def meth2
        super
        $meth2 << 'ClassMethods4.meth2'
      end
    end

    inheritable_extend ClassMethods4
  end

  class X
    include B
  end

  def test_container
    assert_equal ModuleTest::A, ModuleTest::A::ClassMethods1.container
    assert_equal ModuleTest::B, ModuleTest::B::ClassMethods3.container
  end

  def test_extensions
    assert_equal [ModuleTest::B::ClassMethods4, ModuleTest::B::ClassMethods3,
      ModuleTest::A::ClassMethods2, ModuleTest::A::ClassMethods1], X.extensions
  end
  
  def test_inheritable_extend
    assert_equal 'meth1', $meth1
    X.meth2
    assert_equal ["ClassMethods2.meth2", "ClassMethods4.meth2"], $meth2
    assert_equal 'meth1', X.meth1
    assert_equal 'meth3', X.meth3
  end  
end