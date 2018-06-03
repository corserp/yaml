#!/usr/bin/ruby19
# encoding: utf-8

require 'test/unit'

$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib')).uniq!
require 'kinda-core'

class ForwardableTest < Test::Unit::TestCase
  def setup
    @human_class = Class.new do
      include Kinda::Core
    end
    @human = @human_class.new
  end

  def test_delegate_attribute
    @child = @human_class.new
    @father = @human_class.new
    @child.attr_accessor :father
    @child.father = @father
    assert_equal @father, @child.father
    @father.attr_accessor :name
    @father.name = 'Dave'
    @child.delegate_attr :name => :father
    assert_equal 'Dave', @child.name
    @child.name = 'Fred'
    assert_equal 'Fred', @child.name
    assert_equal 'Fred', @father.name
  end

  def test_delegate_attribute_with_filter
    @child = @human_class.new
    @father = @human_class.new
    @child.attr_accessor :father
    @child.father = @father
    assert_equal @father, @child.father
    @father.attr_accessor :name
    @father.name = 'Dave'
    @child.delegate_attr_reader_with_filter :name => :father do |value|
      value + ' junior'
    end
    assert_equal 'Dave junior', @child.name
    @child.delegate_attr_writer_with_filter :name => :father do |value|
      value.capitalize
    end
    @child.name = 'fred'
    assert_equal 'Fred junior', @child.name
    assert_equal 'Fred', @father.name
  end
end