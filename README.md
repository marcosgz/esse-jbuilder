# Esse Jbuilder Plugin

Extends the [esse](https://github.com/marcosgz/esse) search to use [jbuilder](https://github.com/rails/jbuilder) as the default template engine.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'esse-jbuilder'
```

And then execute:

```bash
$ bundle install
```

## Configuration

This gem adds the `search_view_path` configuration option to the `Esse::Config` class.

```ruby
Esse.configure do |config|
  config.search_view_path = 'app/searches'
end
```

This options is used to set the default path where the search templates are located. The default value is `app/searches`.

## Usage

The block passed to the `search` method will be evaluated in the context of a `JbuilderTemplate` instance.

```ruby
# Single index
@search = UsersIndex.search(params[:q]) do |json|
  json.query do
    json.match do
      json.set! 'name', params[:q]
    end
  end
end

# Multiple indexes
@search = Esse.cluster.search(CitiesIndex, CountiesIndex) do |json|
  json.query do
    json.match do
      json.set! 'name', params[:q]
    end
  end
end
```

example using partials

```ruby
CitiesIndex.search do |json|
  json.query do
    json.bool do
      json.must do
        json.child! do
          json.match do
            json.set! 'name', params[:q]
          end
        end
        if (states = params[:state_abbr])
          json.child! do
            json.partial! 'shared/terms_field', field: 'state_abbr', values: state_abbr
          end
        end
      end
    end
  end
  json.aggs do
    json.states do
      json.partial! 'shared/field_aggregation', field: 'state_abbr'
    end
  end
end
```

### Rendering

For more advanced rendering, you can also use the standalone `Esse::Jbuilder::Template` or `Esse::Jbuilder::ViewTemplate` classes.

* Esse::Jbuilder::Template - This class is used to render a template block.
* Esse::Jbuilder::ViewTemplate - This class is used to render a template from a file. Note that you must have the `jbuilder` template handler registered in your Rails application.

This brings a very powerful to create searcher classes. Example:

```ruby
class Searchers::CitiesSearcher
  extend Forwardable
  def_delegators :search, :results

  def initialize(params)
    @params = params.transform_keys(&:to_sym)
  end

  private

  attr_reader :params

  def search
    CitiesIndex.search(body: body).limit(params[:limit] || 10).offset(params[:offset] || 0)
  end

  def body
    Esse::Jbuilder::ViewTemplate.call('cities/search', **params)
  end
end

Searchers::CitiesSearcher.new(params).results
```


## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake none` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/marcosgz/esse-jbuilder.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
