#!/usr/bin/env ruby

begin
  require 'rubygems'
rescue LoadError
end
require 'yaml'
require 'activerecord'

DATA_PATH = File.join(File.dirname(__FILE__),'/..')

dbinfo = YAML.load(open(DATA_PATH+'/database.yml'))
ActiveRecord::Base.establish_connection(dbinfo)
load(DATA_PATH+'/schema.rb')
