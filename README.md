# Miniconfig

[![Build Status](https://travis-ci.org/patriciomacadden/minitest.png)](https://travis-ci.org/patriciomacadden/miniconfig)
[![Code Climate](https://codeclimate.com/github/patriciomacadden/miniconfig.png)](https://codeclimate.com/github/patriciomacadden/miniconfig)

Minimalistic configuration files for your projects.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'miniconfig'
```

And then execute:

```
$ bundle
```

Or install it yourself as:

```
$ gem install miniconfig
```

## Usage

Create your application configuration files in yaml format. For instance:

```yaml
# config/app.yml
app:
  name: Amazing app with great configuration files handling
  version: 0.1.0
some:
  cool:
    setting: Some Cool Setting
  cooler:
    setting: Some Other Even Cooler Setting
```

Then, load this configuration into an object:

```ruby
config = Miniconfig.load 'config/app.yml'
```

And access your application configuration:

```ruby
config.app.name # => "Amazing app with great configuration files handling"
config.app.version # => "0.1.0"
config.some.cool.setting # => "Some Cool Setting"
config.some.other.setting # => "Some Other Even Cooler Setting"
```

### Loading more than one file

You can load more than one file. Suppose that we have the file `config/app.yml`
as defined above (it contains general settings for your application) and
`config/development.yml` (which contains settings for your application in
development mode).

You can load those files using:

```ruby
config = Miniconfig.load 'config/app.yml', 'config/development.yml'
```

And then access your application configuration as usual:

```ruby
config.app.name # => "Amazing app with great configuration files handling"
config.app.version # => "0.1.0"
config.some.cool.setting # => "Some Cool Setting"
config.some.other.setting # => "Some Other Even Cooler Setting"
```

#### Precedence

When loading multiple yaml files, the values defined in the second have higher
precedence. See the example:

```yaml
# config/app.yml
app:
  name: Application Name
  version: 0.1.0
```

```yaml
# config/development.yml
app:
  name: Application Name [DEVELOPMENT]
some:
  setting: Some Setting
```

```ruby
config.app.name # => "Application Name [DEVELOPMENT]"
config.app.version # => "0.1.0"
config.some.setting # => "Some Setting"
```

## Integration with Sinatra

The integration with sinatra is pretty simple, you must create a
helper method that creates the config object:

```ruby
require 'sinatra'

helpers do
  def config
    @config ||= Miniconfig.load 'config/app.yml'
  end
end

get '/' do
  config.app.name
end
```

## Integration with Rails

The integration with rails is also pretty straightforward, as in
the previous example, just create a helper:

```ruby
# config/application.rb

module SomeApplication
  class Application < Rails::Application
    # configuration options here

    def miniconfig
      @miniconfig ||= Miniconfig.load 'config/app.yml'
    end
  end
end
```

And then access the application instance:

```ruby
class SomeController < ApplicationController
  def index
    config = SomeApplication::Application.instance.miniconfig

    render text: config.app.name
  end
end
```

Obviously, this can be done in many different ways and integrated
with any Ruby application. But, for instance, if you need to access
the configuration options only in your rails app controllers, define this
method on the `ApplicationController`. Choose the one that suits best, and
may the force be with you.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## TODO

* Do not depend on `activesupport` (a.k.a. implement `deep_merge`)
