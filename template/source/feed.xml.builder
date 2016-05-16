articles ||= blog.articles[0..5]
tagname ||= nil
title = config.casper[:blog][:name]
subtitle = config.casper[:blog][:description]

xml.instruct!
xml.feed "xmlns" => "http://www.w3.org/2005/Atom" do
  site_url = config.casper[:blog][:url]
  xml.title tagname.present? ? "#{title}: #{tagname}" : title
  xml.subtitle tagname.present? ? "Posts tagged with #{tagname}" : subtitle
  xml.id URI.join(site_url, blog.options.prefix.to_s)
  xml.link "href" => URI.join(site_url, blog.options.prefix.to_s)
  xml.link "href" => URI.join(site_url, current_page.path), "rel" => "self"
  xml.updated(articles.first.date.to_time.iso8601) if articles.present?
  xml.author { xml.name config.casper[:author][:name] }

  articles.each do |article|
    xml.entry do
      xml.title article.title
      xml.link "rel" => "alternate", "href" => URI.join(site_url, article.url)
      xml.id URI.join(site_url, article.url)
      xml.published article.date.to_time.iso8601
      xml.updated File.mtime(article.source_file).iso8601
      xml.author { xml.name config.casper[:author][:name] }
      xml.summary summary(article), "type" => "html"
    end
  end
end
