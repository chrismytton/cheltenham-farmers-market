require 'bundler/setup'
require 'open-uri'
require 'nokogiri'
require 'pry'

html = Nokogiri(open('https://www.cheltenham.gov.uk/info/24/markets/491/cheltenham_farmers_market').read)

dates = html.search('#content ul').first.search('li').map(&:text)
dates_parsed = dates.flat_map { |d| month = d.split(' ').last; d.scan(/\d+/).map { |n| "#{n} #{month} 2018" } }.map { |d| Date.parse(d) }

puts dates_parsed
