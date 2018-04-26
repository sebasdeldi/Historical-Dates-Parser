require 'nokogiri'
require 'open-uri'

months = ['January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November','December']
days = 0
data = File.new("historicalData.txt", "w+")


months.each do |month|
	if month == "February"
		days = 28
	elsif month == "April" || month == "June" || month == "September" || month == "November"
		days = 30
	else
		days = 31
	end

	(1..days).each do |day|
		data.puts "** DATA FROM " + month.to_s + ' / ' + day.to_s + " **"
		puts "** SCRAPING DATA FROM " + month.to_s + ' / ' + day.to_s + " **"
		link = 'https://en.wikipedia.org/wiki/'+month.to_s+'_' + day.to_s
		doc = Nokogiri::HTML(open(link, {ssl_verify_mode: 0}))
		doc.css('h2:nth-of-type(1) + ul li').each do |link|
			data.puts link.content
		end
		data.puts "--------------------------------------------------------------------------------------------"
	end
end
