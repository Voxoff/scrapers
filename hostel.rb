# require 'open-uri'
# require 'nokogiri'

# url="https://www.hostelworld.com/search?search_keywords=London%2C+England&country=England&city=London&date_from=2018-10-03&date_to=2018-10-04&number_of_guests=1&disableunderrated=true&ShowAll=1"
# doc = Nokogiri::HTML(open(url).read)

require 'open-uri'
require 'nokogiri'
require 'watir'
require  'capybara'
 require  'selenium-webdriver'
 require 'webdrivers'
 # require  'chromedriver-helper'
url="https://www.hostelworld.com/search?search_keywords=London%2C+England&country=England&city=London&date_from=2018-10-03&date_to=2018-10-04&number_of_guests=1&disableunderrated=true&ShowAll=1"


browser = Watir::Browser.new
browser.goto url

sleep 10
doc = Nokogiri::HTML.parse(browser.html) ; nil
  results = []
doc.search(".fabresult").each do |element|
  results << {
    title: element.search("h2").map{|i| i.children.children.text.strip}.first,
    image_url: element.search(".active").children.first.attributes["data-lazy"].value.strip,
    link_url_or_address: element.search("h2").children[1].attributes["href"].value
  }
end

browser.close if browser

results.each do |result|
  meta_browser = Watir::Browser.new
  meta_browser.goto result[:link_url_or_address]
  sleep 5
  5.times do 
    meta_browser.send_keys :space
  end
  sleep 5
  5.times do 
    meta_browser.send_keys :space
  end
  sleep 5
  meta_doc = Nokogiri::HTML.parse(meta_browser.html) ; nil
  address = meta_doc.search('.address-street').text ; nil
  result[:link_url_or_address] = address
  meta_browser.close if meta_browser
end

