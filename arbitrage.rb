require 'open-uri'
require 'nokogiri'

url = "https://coingi.com/trade/ltc-btc"

doc = Nokogiri::HTML(open(url).read)

data = doc.xpath("//tbody/tr[14]")
data_one = doc.xpath("//tbody/tr")
# /tr[15]/td[1]/span[1]
# puts data
puts data_one

# betterdata.search(".no")
