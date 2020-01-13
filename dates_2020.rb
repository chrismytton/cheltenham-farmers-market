require 'date'

# The market will run on the 2nd and last Friday of every month, from
# January to November and then on the 2nd and 3rd Friday in December.

markets_dates = 1.upto(12).flat_map do |month|
  start_of_month = Date.new(2020, month)
  end_of_month = start_of_month.next_month.prev_day
  fridays = start_of_month.upto(end_of_month).select(&:friday?)
  if month != 12
    [fridays[1], fridays.last]
  else
    [fridays[1], fridays[2]]
  end
end

puts "BEGIN:VCALENDAR
VERSION:2.0
PRODID:cheltenham-farmers-market-dates-script
CALSCALE:GREGORIAN"

date_format = '%Y%m%dT%H%M%S'

markets_dates.each do |date|
  start_time = DateTime.parse("#{date} 09:00").strftime(date_format)
  end_time = DateTime.parse("#{date} 14:00").strftime(date_format)

  puts "BEGIN:VEVENT
DTSTAMP:#{DateTime.now.strftime(date_format)}Z
UID:#{start_time}@cheltenham-farmers-market-dates-script
DTSTART:#{start_time}
DTEND:#{end_time}
SUMMARY:Cheltenham farmers' market
END:VEVENT"
end

puts "END:VCALENDAR"

