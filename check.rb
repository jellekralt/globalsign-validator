#!/usr/bin/env ruby 

require 'net/http'
require 'ansi_colors'

domains = File.open('domains.txt').read
domains.gsub!(/\r\n?/, "\n")

valid = 0
missing = 0

puts "\n\nChecking domains for 'globalsign.html'\n".ansi_bold

domains.each_line do|n|

	domain = n.gsub(/\s+/, "")

	if(domain != '')
		check = Net::HTTP.get(domain, '/globalsign.html')
		if check == "hello globalsign"
			printf "%-40s [ %s ]\n", domain, "VALID".ansi_green 
			valid += 1
		else 
			printf "%-40s [ %s ]\n", domain, "MISSING".ansi_red 
			missing += 1
		end
	end
end

puts "\n"
puts "Found " + valid.to_s.ansi_green.ansi_bold + " domains with a correct globalsign.html file"
puts "Found " + missing.to_s.ansi_red.ansi_bold + " domains without a correct globalsign.html file"