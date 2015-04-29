#!/usr/bin/ruby

require 'rubygems'
require 'nokogiri' 
require 'open-uri'
require 'etc'


# Returns formatted date string.
def getTodaysDate(format)
	return Time.now.strftime(format)
end


# Returns an appropriate URL for a specific GitHub user.
def getGitHubURLForUsername(username)
	return "https://github.com/" + username
end


# Retuns the current user's name who is logged into the local machine.
def getCurrentUser 
	return Etc.getlogin
end


# Writes to a file (writes to users desktop - OSX)
def writeToFile(fileContent) 
	filetoWrite = File.new("/Users/" + getCurrentUser + "/Desktop/GitHubCommitCount.txt", "a")
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
