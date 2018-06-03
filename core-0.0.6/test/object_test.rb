#!/usr/bin/ruby19
# encoding: utf-8

require 'test/unit'

$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib')).uniq!
require 'kinda-core'

class ObjectTest < Test::Unit::TestCase
  def test_tap
    assert_equal 'Hello', 'Hello'.tap { |str| assert_equal 'HELLO', str.upcase }
    assert_equal 'Hello', 'Hello'.tap.upcase
  end  
  
  def test_try
    assert_equal nil, 'Hello'.try(:undefined)
    assert_equal 'HELLO', 'Hello'.try(:upcase)
    assert_equal 'hello', 'Hello'.try(:upcase).try(:downcase)    
  end
  
  def test_parse_arguments
    assert_equal [1, 2, {}], parse_arguments([], 1, 2)
    assert_equal [3, 4, {}], parse_arguments([3, 4], 1, 2)
    assert_raise(ArgumentError) { parse_arguments([3, 4, 5], 1, 2) }
    assert_equal [1, 2, {:a => 'c', :b => 'd'}], parse_arguments([:a => 'c', :b => 'd'], 1, 2)
    assert_equal [3, 2, {:a => 'c', :b => 'd'}], parse_arguments([3, :a => 'c', :b => 'd'], 1, 2)
  end
end