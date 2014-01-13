# GeneralStore
[![Build Status](https://travis-ci.org/stuartnelson3/general_store.png?branch=master)](https://travis-ci.org/stuartnelson3/general_store)

General Store is an easy way to store user-specific credentials for an
app on a user's machine.

## Installation

Add this line to your application's Gemfile:

    gem 'general_store'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install general_store

## Usage

Set the directory you want your `config.yml` file saved in, and push in
the values you want to store:

``` ruby
GeneralStore.create '~/.your_directory' do |gs|
  gs.consumer_key = 'my key'
  gs.consumer_secret = 'my secret'
  gs.oauth_token = 'oauth token'
  gs.oauth_token_secret = 'oauth token secret'
end
```

And then access them:

``` ruby
store = GeneralStore.read '~/.your_directory'

store.consumer_key
  # => 'my key'
store.consumer_secret
  # => 'my secret'
```

Apply any arbitrary name to your attributes when going into your store;
they will be accessible when you take them out:

``` ruby
GeneralStore.create '~/.some_other_dir' do |gs|
  gs.SoMethIngCRAZY = 'I couldnt think of a good example'
end

store = GeneralStore.read '~/.some_other_dir'
store.SoMethIngCRAZY
  # => 'I couldnt think of a good example'
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
