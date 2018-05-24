#!/usr/bin/ruby19
# encoding: utf-8

require 'test/unit'

$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib')).uniq!
require 'kinda-core'

class AccessorTest < Test::Unit::TestCase
  def setup
    @human_class = Class.new do
      include Kinda::Core
    end
    @human = @human_class.new
  end

  def test_attribute_defined_at_class_level
    @human_class.class_eval do
      attr_accessor :name
    end
    assert_nil @human.name
    @human.name = 'Dave'
    assert_equal 'Dave', @human.name
    @human.name 'Fred'
    assert_equal 'Fred', @human.name
  end
  
  def test_attribute_defined_at_instance_level
    @human.attr_accessor :name
    assert_nil @human.name
    @human.name = 'Dave'
    assert_equal 'Dave', @human.name
    @human.name 'Fred'
    assert_equal 'Fred', @human.name
    @other_human = @human_class.new
    assert_raise NoMethodError do
      @other_human.name
    end
  end

  def test_attribute_with_block_defined_at_class_level
    @human_class.class_eval do      
      attr_reader :name do |capitalize=false|
        capitalize ? @the_name.capitalize : @the_name
      end
      attr_writer :name do |value|
        @the_name = value
      end
    end
    assert_equal nil, @human.name
    @human.name = 'Dave'
    assert_equal 'Dave', @human.name
    @human.name = 'fred'
    assert_equal 'Fred', @human.name(true)
  end
 
  def test_attribute_with_filter_defined_at_class_level
    @human_class.class_eval do
      attr_accessor :nickname
      
      attr_reader_with_filter :name do |value|
        value || nickname || 'Mike'
      end
      attr_writer_with_filter :name do |value|
        value.capitalize
      end
    end
    assert_equal 'Mike', @human.name
    @human.nickname = 'Mikey'
    assert_equal 'Mikey', @human.name
    @human.name = 'dave'
    assert_equal 'Dave', @human.name
    @human.name 'FRED'
    assert_equal 'Fred', @human.name
  end
    
  def test_attribute_redirection
    @human.attr_accessor :name => :@the_name
    assert_nil @human.name
    @human.name = 'Dave'
    assert_equal 'Dave', @human.name
    assert_equal 'Dave', @human.instance_variable_get(:@the_name)
    @human.name = 'Fred'
    assert_equal 'Fred', @human.name
    @human.attr_accessor :last_name => :name
    assert_equal 'Fred', @human.last_name
    @human.last_name = 'Mike'
    assert_equal 'Mike', @human.last_name
    assert_equal 'Mike', @human.name
  end
  
  def test_attribute_delegation
    @child = @human_class.new
    @father = @human_class.new
    @child.attr_accessor :father
    @child.father = @father
    assert_equal @father, @child.father
    @father.attr_accessor :name
    @father.name = 'Dave'
    @child.attr_accessor :name => [:father, :name]
    assert_equal 'Dave', @child.name
    @child.name = 'Fred'
    assert_equal 'Fred', @child.name
    assert_equal 'Fred', @father.name
  end
    
  def test_attribute_double_delegation
    @child = @human_class.new
    @mother = @human_class.new
    @husband = @human_class.new
    @child.attr_accessor :mother
    @child.mother = @mother
    @mother.attr_accessor :husband
    @mother.husband = @husband    
    assert_equal @husband, @child.mother.husband
    @husband.attr_accessor :name
    @husband.name = 'Dave'
    @child.attr_accessor :name => [:mother, :husband, :name]
    assert_equal 'Dave', @child.name
    @child.name = 'Fred'
    assert_equal 'Fred', @child.name
    assert_equal 'Fred', @husband.name
  end
  
  def test_attribute_with_default
    @human.attr_accessor_with_default :name, 'Bart'
    assert_equal 'Bart', @human.name
    @human.name = 'Dave'
    assert_equal 'Dave', @human.name
  end
end