require "open-uri"
require "nokogiri"


class FetchPageTitleJob < ApplicationJob
  queue_as :default

  def perform(url_id)
    url = UrlShortner.find_by(id: url_id)
    return unless url

    doc = Nokogiri::HTML(URI.open(url.given_url))
    title_text = doc.css('title').first.text.strip  rescue ''
    url.update(title: title_text)
    # Do something later
  end
end
