#!/usr/bin/env ruby 

require 'net/http'
require 'ansi_colors'

domains = File.open('domains.txt').read
domains.gsub!(/\r\n?/, "\n")

domains.each_line do|n|

	domain = n.gsub(/\s+/, "")

	if(domain != '')
		check = Net::HTTP.get(domain, '/globalsign.html')
		if check == "hello globalsign"
			printf "%-40s [ %s ]\n", domain, "VALID".ansi_green 
		else 
			printf "%-40s [ %s ]\n", domain, "MISSING".ansi_red 
		end
	end
end