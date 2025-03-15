# Orthoses::Config

[Orthoses](https://github.com/ksss/orthoses) extension for [Config](https://github.com/rubyconfig/config).
Orthoses::Config automatically generates RBS for methods added by Config.

```yml
# config/settings.yml
foo:
  bar: 'bar'
```

```rbs
class Object
  Settings: Config::Options & Config::_Options_Root
end

interface Config::_Options_Root
  def foo: () -> (Config::Options & Config::_Options_Root_foo)
end

interface Config::_Options_Root_foo
  def bar: () -> String
end
```

```rb
Settings         #=> Config::Options & Config::_Options_Root
Settings.foo     #=> Config::Options & Config::_Options_Root_foo
Settings.foo.bar #=> String
```

## Installation

TODO: Replace `UPDATE_WITH_YOUR_GEM_NAME_IMMEDIATELY_AFTER_RELEASE_TO_RUBYGEMS_ORG` with your gem name right after releasing it to RubyGems.org. Please do not do it earlier due to security reasons. Alternatively, replace this section with instructions to install your gem from git if you don't plan to release to RubyGems.org.

Install the gem and add to the application's Gemfile by executing:

```bash
bundle add UPDATE_WITH_YOUR_GEM_NAME_IMMEDIATELY_AFTER_RELEASE_TO_RUBYGEMS_ORG
```

If bundler is not being used to manage dependencies, install the gem by executing:

```bash
gem install UPDATE_WITH_YOUR_GEM_NAME_IMMEDIATELY_AFTER_RELEASE_TO_RUBYGEMS_ORG
```

## Usage

It can be used as orthoses middleware.

```rb
use Orthoses::Config
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/ksss/orthoses-config. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/ksss/orthoses-config/blob/main/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Orthoses::Config project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/ksss/orthoses-config/blob/main/CODE_OF_CONDUCT.md).
