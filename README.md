# Ruby::Api::Esignatur

Get your documents digitalized with https://www.esignatur.dk (esignatur is Denmark's safest digital signing solution for both private and public companies).

This gem is a Ruby wrapper for the esignatur API & provides all supported methods. Get the API details here: https://api.esignatur.dk/

## Installation

If integrating with Rails 3.x, 4.x version:

Add this line to your application's Gemfile:

```ruby
gem 'ruby-api-esignatur'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install ruby-api-esignatur

## Get Started

 1. Get started with [Signup] https://www.esignatur.dk/kom-i-gang/
 2. Before creating signing orders, you should have:
    * SenderEmail (E-mail address of sender)
    * CreatorId (Id of document creator).
    * Identification (Cvr/Cpr of signer).

##Usage

####Headers:

Set the default headers with your signatur ID:

```ruby
  headers = {'Content-Type' => 'application/json',
    'X-Esignatur-Id' => '1aaXXXX-XXXX-XXXX-XXXX-XXXXXXXXX044'}
```

##### Creating Signing Order (https://api.esignatur.dk/Documentation/Order):
 
 1. Get the Base64 encoded document of the signing pdf. For eg:

 ```ruby
    pdf_encoded = Base64.encode64(open("sample_document.pdf").to_a.join)
 ```
 2. Get all the signing details in a hash (Check https://api.esignatur.dk/Documentation/Order for more details):
  
 ```ruby
    signing_body = {CreatorId: "9208-XXXX-X-XXXXXXXXX650",
         SenderEmail: "sender@example.com",
         CommonNote: "This is a test order for signing.",
         EndDate: Time.now,
         Documents: [
           {
             title: "Signing Contract",
             Filename: "contract.pdf",
             DocumentFormat: "Pdf",
             DocumentData: pdf_encoded
           }
         ],
         steps: [
           {
             Signers: [
               {
                 name: 'Name1',
                 email: 'signer@example.com',
                 identification: '23434234234234'
               }
             ]
           }
         ]
      }

 ```
 
 3. Create request api client with headers:
 
 ```ruby
    client = Esignatur::APIClient.new(headers)
 ```
 
 4. Send the creating order request with order details:
  ```ruby 
    response = client.create_order(signing_body)
  ```
  
##### Get All pending orders:
  ```ruby
  response = client.pending_orders("sender@example.com") #E-mail address of sender. Set to blank disable e-mail filtering.
  ```
  
##### Get Order Status:
  ```ruby
  response = client.order_status(("sender@example.com", "c00XXXXX-XXXX-XXXX-XXXX-XXXXXXXXXX608")
  # More details on: https://api.esignatur.dk/Documentation/Status
  ```
  
##### Download Signed Document:
  Note: The output from these methods tends to be quite large.
  ```ruby
  response = client.get_document(Id: "34XXXXXX-XXXX-XXXX-XXXX-XXXXXXXXX166", DocumentIndex: 0)
  # More details on: https://api.esignatur.dk/Documentation/Pades
  ```
  
  
 


## Submitting an Issue
We use the [GitHub issue tracker ](https://github.com/moorem/ruby-api-esignatur/issues) to track bugs and features.


## Contributing

1. Fork it ( https://github.com/[my-github-username]/ruby-api-esignatur/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
# ruby-api-esignatur


## <a name="rubies">Supported Rubies</a>
This library aims to support the following Ruby implementations:

* Ruby >= 1.9
* [JRuby](http://www.jruby.org/)
* [Rubinius](http://rubini.us/)
* [Ruby Enterprise Edition](http://www.rubyenterpriseedition.com/)

If something doesn't work on one of these interpreters, it should be considered
a bug.

This library may inadvertently work (or seem to work) on other Ruby
implementations, however support will only be provided for the versions listed
above.

If you would like this library to support another Ruby version, you may
volunteer to be a maintainer. Being a maintainer entails making sure all tests
run and pass on that implementation. When something breaks on your
implementation, you will be personally responsible for providing patches in a
timely fashion. If critical issues for a particular implementation exist at the
time of a major release, support for that Ruby version may be dropped.

## <a name="todos">Todos</a>
* Need to add other API methods.
* Need to fully test all the methods.
* Need to add a history log for additional contributers.


##Credits
[![moorem.com: Ruby on Rails, iOS and Android developers](http://www.moorem.com/images/logo.png "Ruby on Rails, iOS and Android developers")](http://moorem.com)

Copyright (c) 2015 [moorem.com](http://moorem.com "Ruby on Rails, iOS and Android developers"), released under the [LICENSE](https://github.com/moorem/ruby-api-esignatur/blob/master/LICENSE.txt).


