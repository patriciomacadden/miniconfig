# Miniconfig

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
  name: Application Name
  version: 0.1.0
some:
  cool:
    setting: Some Cool Setting
  other:
    setting: Some Other Setting
```

Then, load this configuration into an object:

```ruby
config = Miniconfig.load 'config/app.yml'
```

And access your application configuration:

```ruby
config.app.name # => "Application Name"
config.app.version # => "0.1.0"
config.some.cool.setting # => "Some Cool Setting"
config.some.other.setting # => "Some Other Setting"
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
config.app.name # => "Application Name"
config.app.version # => "0.1.0"
config.some.cool.setting # => "Some Cool Setting"
config.some.other.setting # => "Some Other Setting"
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

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
