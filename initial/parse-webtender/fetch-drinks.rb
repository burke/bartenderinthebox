#!/usr/bin/env ruby

require 'rubygems'
require 'open-uri'

def get_page( i )
  url = "http://www.webtender.com/db/drink/#{i}"
  
  f=File.open("#{i}.html",'w')
  f.puts open(url).read
  f.close

end

for i in 1513..6215
  puts "Fetching Drink ID ##{i}"
  get_page(i)
end

