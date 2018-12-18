require 'pry'
require 'open-uri'


class BookReview::Scraper

  def self.scrape_book

     index_page = Nokogiri::HTML(open('https://commonsensemedia.org/lists/50-books-all-kids-should-read-before-theyre-12'))

      doc = index_page.css("div.views-row")

      doc.each do |book|

       attributes = {

        url: "https://commonsensemedia.org" << book.css("div.views-field.views-field-title.result-title a").attribute("href").value,
        title: book.css("div.views-field.views-field-title.result-title a")[0].children.text,
        author: book.css("em.field-content")[0].children.text,
        short_desc: book.css("div.views-field.views-field-field-one-liner.one-liner")[0].children.text.strip,
        age: book.css("div.csm-green-age")[0].children.text

          }

        book = BookReview::Book.new(attributes)

     end
end


  def self.scrape_review(book)

    review_page = Nokogiri::HTML(open(book.url))

      doc = review_page.css("div.panel-content-mid-main.panel-panel")

      # binding.pry

      doc.each do |review|

        attributes = {

       story: review.css("div.shutter-summary-pane.panel-pane.pane-entity-field.pane-node-field-what-is-story p").text,

       parents_need_to_know: review.css("div.shutter-summary-pane.panel-pane.pane-entity-field.pane-node-field-parents-need-to-know p").text,

       any_good: review.css("div.field.field-name-field-any-good.field-type-text-long.field-label-hidden p").text,

       family_topics: review.css("div.field.field-name-field-family-topics.field-type-text-long.field-label-hidden p").text,

     }

        # attributes[:story] = review.css("div.shutter-summary-pane.panel-pane.pane-entity-field.pane-node-field-what-is-story p").text
        #
        # attributes[:parents_need_to_know] = review.css("div.shutter-summary-pane.panel-pane.pane-entity-field.pane-node-field-parents-need-to-know p").text
        #
        # attributes[:any_good] = review.css("div.field.field-name-field-any-good.field-type-text-long.field-label-hidden p").text
        #
        # attributes[:family_topics] = review.css("div.field.field-name-field-family-topics.field-type-text-long.field-label-hidden p").text
        #

        review = BookReview::Review.new(attributes)

      end
  end



end
