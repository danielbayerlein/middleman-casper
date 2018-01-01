# middleman-casper

[![Casper Version](https://img.shields.io/badge/Casper-1.4.0-brightgreen.svg?style=flat)](https://github.com/TryGhost/Casper)

The [Casper](https://github.com/TryGhost/Casper) theme
([Ghost](https://github.com/TryGhost/Ghost)) for
[Middleman-Blog](https://middlemanapp.com/basics/blogging/) v4.x

<p align="center">
  <img src="./screenshot.png" width="400" alt="middleman-casper screenshot">
</p>

## Installation

1. Create a new project with the template:

  ```bash
  middleman init -T danielbayerlein/middleman-casper MY_PROJECT_FOLDER
  ```

2. Change the `casper` settings in `config.rb`.

## Usage

Start a local web server running at `http://localhost:4567/` with:

```bash
bundle exec middleman server
```

Create a static file with:

```bash
bundle exec middleman build
```

For help, see the official [Middleman](https://middlemanapp.com) website.

### Author

Configurable in *config.rb*:

```ruby
config[:casper] = {
  ...
  author: {
    name: 'Middleman'
  }
  ...
}
```

### Navigation

Configurable in *config.rb*:

```ruby
config[:casper] = {
  ...
  navigation: {
    "Home" => "/",
    "GitHub" => "https://github.com",
    "Author" => "/author/middleman/"
  }
  ...
}
```

### Logo

Configurable in *config.rb*:

```ruby
config[:casper] = {
  ...
  blog: {
    logo: 'my-awesome-blog-logo.png' # sources/images/my-awesome-blog-logo.png
  }
  ...
}
```

### Pages

Content of *example.html.markdown*:

```markdown
---
title: Example
layout: page
---

Welcome!
```

### Covers

Covers are availible in pages and articles. Content of *example.html.markdown*:

```markdown
---
title: Example
layout: page
cover: my-awesome-blog-cover.png # sources/images/my-awesome-blog-cover.png
---

Welcome!
```

## Special Thanks

* [Ghost Foundation](https://github.com/TryGhost/Ghost) for
  [Casper](https://github.com/TryGhost/Casper)

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new [Pull Request](../../pull/new/master)

## License

The MIT License (MIT)

Copyright (c) 2013-2018 Daniel Bayerlein

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
