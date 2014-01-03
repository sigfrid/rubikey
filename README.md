# Rubikey

Rubikey is another Ruby (2.1+) library for decoding, decrypting, parsing, and verifying [YubiKey](http://www.yubico.com/products/yubikey-hardware/) OTPs against [Yubico Validation Protocol Version 2.0](https://github.com/Yubico/yubikey-val/wiki/ValidationProtocolV20).

## Installation

Add this line to your application's Gemfile:

    gem 'rubikey', git: 'git@github.com:sigfrid/rubikey.git' 

And then execute:

    $ bundle

## Usage

### Key configuration 

Once you have instantiated a Rubikey::OTP object by passing to it your otp, you can get the YubiKey configuration by calling ```config``` and passing to it your Yubikey ```secret_key```.

It returns a Rubikey::KeyConfig object that provides:
+ public_id: Yubikey identifier.
+ secret_it: hexadecimal identifier that is encrypted in OTP.
+ insert_counter: integer that represents how many time the YubiKey has been plugged in a device.

```ruby
unique_passcode = 'ccccccbtcvvhkbkvkdrbbjjlkvgvtvrvibekdcentbti'
secret_key = 'ecde18dbe76fbd0c33330f1c354871db'

opt = Rubikey::OTP.new(unique_passcode)
keyconfig = opt.config(secret_key)    #=> Rubikey::KeyConfig


keyconfig.public_id                   #=> 'ccccccbtcvvh'
keyconfig.secret_id                   #=> '8792ebfe26cc'
keyconfig.insert_counter              #=> 1

```


### Authenticate against a Yubico Validation Protocol Version 2.0 compatible server (such as YubiCloud)

Once you have instantiated a Rubikey::OTP object by passing to it your otp, you can validate it by calling ```authenticate``` and passing to it your Yubikey ```api_id``` and ```api_key```.


If you use YubiCloud you can get your API id and key at [yubico.com/getapykey](https://upgrade.yubico.com/getapikey/)

It returns a Rubikey::ApiAuthentication object that provides:
+ status: Authentication outcome.

```ruby
unique_passcode = 'ccccccbtcvvhkbkvkdrbbjjlkvgvtvrvibekdcentbti'
api_id = 1234
api_key = 'n2AS3oMbInqZ7BbxN/vrFayYUaQ='

opt = Rubikey::OTP.new(unique_passcode)
authentication =  opt.authenticate(api_id: api_id, api_key: api_key)    #=> Rubikey::ApiAuthentication

authentication.status                                                   #=> THE STATUS

```

Refer to [Yubico Validation Protocol Version 2.0 documentation](https://github.com/Yubico/yubikey-val/wiki/ValidationProtocolV20#response) for all the possible statuses and their meanings.

## Specs

Rubikey is specified with [RSpec](http://rspec.info/).

To successfully run the specs you must first add ```spec/authentication_fixtures.yml``` with the following:

```
api_id: 'YOUR YUBIKEY API ID'
api_key: 'YOUR YUBIKEY API KEY '
unique_passcode: 'A NEVER USED YUBIKEY OTP'
```

## Versioning
The gem uses [semantic versioning](http://semver.org/).

## Credits
Teh gem has been inspired by [yubikey](https://github.com/titanous/yubikey)


## Contributing

1. Fork it ( http://github.com/<my-github-username>/rubikey/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
