#!/usr/bin/ruby19
# encoding: utf-8

ruby_files = Dir.glob(File.join(File.dirname(__FILE__), '*_test.rb'))
ruby_files.each { |file| require file }