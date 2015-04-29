#!/usr/bin/ruby

require 'rubygems'
require 'nokogiri' 
require 'open-uri'
require 'daemons'


# Returns formatted date string.
def getTodaysDate(format)
	return Time.now.strftime(format)
end


# Returns an appropriate URL for a specific GitHub user.
def getGitHubURLForUsername(username)
	return "https://github.com/" + username
end


# Writes to a file
def writeToFile(fileContent) 
	filetoWrite = File.new("GitHubCommitCount.txt", "a")
	filetoWrite.puts(fileContent)
	filetoWrite.close
end



githubURL = getGitHubURLForUsername("StephenFox1995")

# Get the page source for that GitHub User.
page = Nokogiri::HTML(open(githubURL))


# Get today's date
todaysDateYYMMDD = getTodaysDate("%Y-%m-%d")


# Create the string to look for css element contained within the 'page' object.
cssElementToFind = "rect[data-date='" + todaysDateYYMMDD + "']"


# Find today's date with the css element 'rect[data-date='todays_date']'
# and get the commit count for today.
commitCount =  page.css(cssElementToFind)[0]['data-count']


todaysDateDDMMYY = getTodaysDate("%d-%m-%Y")



writeToFile(todaysDateDDMMYY + " | " + commitCount)
