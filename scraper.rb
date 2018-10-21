require 'bundler/setup'
require 'open-uri'
require 'nokogiri'
require 'pry'
require 'icalendar'
require 'date'

# Get the HTML of the farmers market webpage
html = Nokogiri(open('https://www.cheltenham.gov.uk/info/24/markets/491/cheltenham_farmers_market').read)

# Pull out the dates and parse them
dates = html.search('#content ul').first.search('li').map(&:text)
dates_parsed = dates.flat_map { |d| month = d.split(' ').last; d.scan(/\d+/).map { |n| "#{n} #{month} 2018" } }.map { |d| Date.parse(d) }
File.write('public/dates.csv', dates_parsed.map(&:to_s).join("\n"))

# Create an ical representation of the dates
cal = Icalendar::Calendar.new
dates_parsed.each do |date|
  start_time = DateTime.parse("#{date} 09:00")
  end_time = DateTime.parse("#{date} 14:00")

  cal.event do |e|
    e.dtstart     = start_time
    e.dtend       = end_time
    e.summary     = "Cheltenham farmers' market"
  end
end

# Write the ical files and a simple index.html to the public/ directory
File.write('public/farmers-markets.ics', cal.to_ical)
