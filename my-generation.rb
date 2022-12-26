#!/usr/bin/env ruby

require 'colorize'

class WhatGen

	def initialize 
		
		@gen = []
		@oldest = 132
		
		# loosley based on: (with tweaks from wikipedia)
		# https://www.careerplanner.com/Career-Articles/Generations.cfm
		
		ages = <<~'AGE'
			Lost Generation|1890-1900
			Interbellum Generation|1901-1913
			Greatest Generation|1913-1924
			Silent Generation|1925-1945
			Baby Boomers|1946-1964
			Generation X|1965-1974
			Xennials|1975-1984
			Millennials|1985-1995
			Generation Z|1996-2012
			Generation Alpha|2013-2025
		AGE
		
		n = 0
		
		ages.split(%r~\n~) do |line|
					
			@gen[n] = {}
			
			@gen[n][:gen]   = line.split(%r~\|~)[0]
			@gen[n][:range] = line.split(%r~\|~)[1]
			@gen[n][:end]   = Time.now.year - (@gen[n][:range].gsub(%r~-\d+$~,%q||).to_i)
			@gen[n][:start] = Time.now.year - (@gen[n][:range].gsub(%r~^\d+-~,%q||).to_i)
			
			n += 1
		
		end
		
	end
		
	def myAge
	
		print %q|> what is your age? |
		age = gets.chomp!
		
		if age.to_i > @oldest then
			puts %q|>|+%Q| I don't think you are really #{age} so quitting :P|.red
			exit 69
		end
						
		unless (age.to_s).match(%r~^\d+$~) then
			puts %q|>|+%Q| You need to pick a number! :P|.red
			exit 69
		end
		
		age = age.to_i
		
		@gen.each_index do |n|
			if age >= @gen[n][:start] and age <= @gen[n][:end]					
				puts %Q|> you are #{age} years old. You are from the '#{@gen[n][:gen]}' generation (#{@gen[n][:range]}).|.green
			end
		end
		
	end
		

end

generation = WhatGen.new
generation.myAge()