require 'sanitize'

###
# Blog settings
###

# Time.zone = "UTC"

activate :blog do |blog|
  # This will add a prefix to all links, template references and source paths
  # blog.prefix = "blog"

  # blog.permalink = "{year}/{month}/{day}/{title}.html"
  # Matcher for blog source files
  # blog.sources = "{year}-{month}-{day}-{title}.html"
  # blog.taglink = "tags/{tag}.html"
  # blog.layout = "layout"
  # blog.summary_separator = /(READMORE)/
  # blog.summary_length = 250
  # blog.year_link = "{year}.html"
  # blog.month_link = "{year}/{month}.html"
  # blog.day_link = "{year}/{month}/{day}.html"
  # blog.default_extension = ".markdown"

  # blog.tag_template = "tag.html"
  # blog.calendar_template = "calendar.html"

  # Enable pagination
  blog.paginate = true
  # blog.per_page = 10
  # blog.page_link = "page/{num}"
end

# Required
set :blog_url, 'http://www.example.com'
set :blog_name, 'Middleman'
set :blog_description, 'Makes developing websites simple.'
set :author_name, 'Middleman'
set :author_bio, 'Middleman is a static site generator using all the ' \
                 'shortcuts and tools in modern web development.'
# Optional
set :author_locaton, ''
set :author_website, ''
set :blog_logo, ''

page '/feed.xml', layout: false

###
# Compass
###

# Change Compass configuration
# compass_config do |config|
#   config.output_style = :compact
# end

###
# Page options, layouts, aliases and proxies
###

# Per-page layout changes:
#
# With no layout
# page "/path/to/file.html", layout: false
#
# With alternative layout
# page "/path/to/file.html", layout: :otherlayout
#
# A path which all have the same layout
# with_layout :admin do
#   page "/admin/*"
# end

# Proxy pages (http://middlemanapp.com/dynamic-pages/)
# proxy "/this-page-has-no-template.html", "/template-file.html", locals: {
#  which_fake_page: "Rendering a fake page with a local variable" }

###
# Helpers
###

# Automatic image dimensions on image_tag helper
# activate :automatic_image_sizes

# Reload the browser automatically whenever files change
# activate :livereload

# Methods defined in the helpers block are available in templates
# helpers do
#   def some_helper
#     "Helping"
#   end
# end

helpers do
  def page_title
    title = blog_name.dup
    if current_page.data.title
      title << ": #{current_page.data.title}"
    elsif is_blog_article?
      title << ": #{current_article.title}"
    end
    title
  end

  def page_description
    if is_blog_article?
      Sanitize.clean(current_article.summary(150, '')).strip.gsub(/\s+/, ' ')
    else
      blog_description
    end
  end

  def page_class
    is_blog_article? ? 'post-template tag-getting-started' : 'home-template'
  end

  def summary(article)
    Sanitize.clean(article.summary, whitespace_elements: %w(h1))
  end

  def author
    {
      bio: author_bio,
      location: author_locaton,
      name: author_name,
      website: author_website
    }
  end

  def tags?(article = current_article)
    article.tags.present?
  end
  def tags(article = current_article, separator = ' | ')
    article.tags.join(separator)
  end

  def current_article_url
    URI.join(blog_url, current_article.url)
  end

  def blog_logo?
    return false if blog_logo.blank?
    File.exists?(File.join('source', images_dir, blog_logo))
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
    '/feed.xml'
  end
end

# Middleman-Syntax - https://github.com/middleman/middleman-syntax
set :haml, { ugly: true }
set :markdown_engine, :redcarpet
set :markdown, fenced_code_blocks: true, smartypants: true
activate :syntax, line_numbers: true

# Pretty URLs - http://middlemanapp.com/pretty-urls/
activate :directory_indexes

# LiveReload - http://middlemanapp.com/livereload/
activate :livereload

set :css_dir, 'stylesheets'

set :js_dir, 'javascripts'

set :images_dir, 'images'

# Build-specific configuration
configure :build do
  # For example, change the Compass output style for deployment
  # activate :minify_css

  # Minify Javascript on build
  # activate :minify_javascript

  # Enable cache buster
  # activate :asset_hash

  # Use relative URLs
  # activate :relative_assets

  # Compress PNGs after build
  # First: gem install middleman-smusher
  # require "middleman-smusher"
  # activate :smusher

  # Or use a different image path
  # set :http_path, "/Content/images/"
end
