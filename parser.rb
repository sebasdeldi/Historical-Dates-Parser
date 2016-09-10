require 'nokogiri'
require 'open-uri'

months = ['January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November','December']
days = 0
data = File.new("historicalData.txt", "w+")


months.each do |month|
	if month == "February"
		days = 28
	elsif month == "April" || "June" || "September" || "November"
		days = 31
	else
		days = 30
	end
	(1..days).each do |day|
		data.puts "** SEARCHING DATA FOR " + month.to_s + ' / ' + day.to_s + " **"
		puts "** SEARCHING DATA FOR " + month.to_s + ' / ' + day.to_s + " **"
		link = 'https://en.wikipedia.org/wiki/'+month.to_s+'_' + day.to_s
		doc = Nokogiri::HTML(open(link, {ssl_verify_mode: 0}))
		doc.css('h2:nth-of-type(1) + ul li').each do |link|
			data.puts link.content
		  	puts link.content
		end
		data.puts "--------------------------------------------------------------------------------------------"
		puts "--------------------------------------------------------------------------------------------"
	end
end
