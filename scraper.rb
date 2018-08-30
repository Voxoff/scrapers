require 'open-uri'
require 'nokogiri'

countries2 = [
    "Afghanistan"
  ]

poi_data = []
results = []

countries2.each do |country|
  url = "https://en.wikivoyage.org/wiki/#{country}"
  html_file = open(url).read
  html_doc = Nokogiri::HTML(html_file)

  html_doc.search('.listing-name a').each do |element|
    place_id = element.inner_html
    href = element.attribute('href')
    if href.to_s.include? "wiki"
      url_2 = "https://en.wikivoyage.org#{href.to_s}"
      html_file_2 = open(url_2).read
      html_doc_2 = Nokogiri::HTML(html_file_2)
      description = html_doc_2.search('.mw-parser-output > p').first.text
      latitiude = html_doc_2.search('abbr.latitude').first.text
      longitude = html_doc_2.search('abbr.longitude').first.text
      # poi_name = element[:title]
      poi_info= {
        # Country: country,
        Description: description,
        Latitude: latitiude,
        Longitude: longitude,
        name: element[:title]
      }
    end
  results << poi_info
  end
poi_data = {
  "#{country}": results
}

end

print poi_data
