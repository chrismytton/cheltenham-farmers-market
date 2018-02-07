require 'bundler/setup'
require 'pry'
require 'icalendar'
require 'date'

cal = Icalendar::Calendar.new

File.read('dates.txt').each_line do |date|
  start_time = DateTime.parse("#{date} 09:00")
  end_time = DateTime.parse("#{date} 14:00")

  cal.event do |e|
    e.dtstart     = start_time
    e.dtend       = end_time
    e.summary     = "Cheltenham farmers' market"
  end
end

puts cal.to_ical
