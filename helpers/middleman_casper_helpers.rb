require 'ostruct'
require 'sanitize'
require 'digest/md5'

module MiddlemanCasperHelpers
  def page_title
    title = blog_settings.name.dup
    if is_tag_page?
      title << ": #{current_resource.metadata[:locals]['tagname']}"
    elsif current_page.data.title
      title << ": #{current_page.data.title}"
    elsif is_blog_article?
      title << ": #{current_article.title}"
    end
    title
  end

  def page_description
    if is_blog_article?
      Sanitize.fragment(current_article.summary(150, '')).strip.gsub(/\s+/, ' ')
    else
      blog_settings.description
    end
  end

  def page_class
    if is_blog_article? || current_page.data.layout == 'page'
      'post-template'
    elsif current_resource.metadata[:locals]['page_number'].to_i > 1
      'archive-template'
    else
      'home-template'
    end
  end

  def summary(article)
    summary_length = article.blog_options[:summary_length]
    Sanitize.fragment(article.summary(summary_length, ''))
  end

  def blog_author
    OpenStruct.new(casper[:author])
  end

  def blog_settings
    OpenStruct.new(casper[:blog])
  end

  def is_tag_page?
    current_resource.metadata[:locals]['page_type'] == 'tag'
  end
  def tags?(article = current_article)
    article.tags.present?
  end
  def tags(article = current_article, separator = ', ')
    capture_haml do
      article.tags.each do |tag|
        haml_tag(:a, tag, href: tag_path(tag))
        haml_concat(separator) unless article.tags.last == tag
      end
    end.gsub("\n", '')
  end

  def current_article_url
    URI.join(blog_settings.url, current_article.url)
  end

  def cover
    if (src = current_page.data.cover).present?
      { style: "background-image: url(#{image_path(src)})" }
    else
      { class: 'no-cover' }
    end
  end
  def cover?
    current_page.data.cover.present?
  end

  def gravatar(size = 68)
    md5 = Digest::MD5.hexdigest(blog_author.gravatar_email.downcase)
    "https://www.gravatar.com/avatar/#{md5}?size=#{size}"
  end
  def gravatar?
    blog_author.gravatar_email.present?
  end

  def twitter_url
    "https://twitter.com/share?text=#{current_article.title}" \
      "&amp;url=#{current_article_url}"
  end
  def facebook_url
    "https://www.facebook.com/sharer/sharer.php?u=#{current_article_url}"
  end
  def google_plus_url
    "https://plus.google.com/share?url=#{current_article_url}"
  end

  def feed_path
    if is_tag_page?
      "#{current_page.url.to_s}feed.xml"
    else
      "#{blog.options.prefix.to_s}/feed.xml"
    end
  end
  def home_path
    "#{blog.options.prefix.to_s}/"
  end
  def author_path
    "#{blog.options.prefix.to_s}/author/#{blog_author.name.parameterize}/"
  end
end
