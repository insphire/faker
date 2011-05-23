Faker
=====
This gem is a port of Perl's Data::Faker library that generates fake data.  

It comes in very handy for taking screenshots (taking screenshots for my
project, [Catch the Best](http://catchthebest.com/) was the original impetus
for the creation of this gem), having real-looking test data, and having your
database populated with more than one or two records while you're doing
development.

Fork Details
------------
This is a fork of the [faker](https://github.com/stympy/faker) gem created by stympy. 

This fork has been created to update the GB locale file and provide the following additional functionality:

(1) address related UK cities and counties:

* Faker::Address.uk_city => "Cambridge"
* Faker::Address.uk_county => "Cornwall"
* Faker::Address.uk_city("Cheshire") => "Chester"
* Faker::Address.uk_city("Chester") => "Cheshire"

(2) address uk_town calls standard city method to return randomly generated name

(3) company name based on locale file formats
(4) company title and department methods returning values based on locale file contents

(5) internet website, facebook, twitter & linkedin methods
(6) internet email address creation for user and domain name:

* Faker::Internet.email => "rebecca@wright.com"
* Faker::Internet.email("Chris Hilton") => "chris.hilton@bailey.co.uk"
* Faker::Internet.email("Chris Hilton","Bartholomew Ltd") => "hilton.chris@bartholomew.com"
* Faker::Internet.email(nil,"Bartholomew Ltd") => "jessica_hill@bartholomew.com"

(7) phone number cell_phone method returning values based on locale file formats

Using the Fork
--------------
To use this fork add the following to your application gemfile:

  gem 'faker', :git => "git://github.com/chrismhilton/faker.git"

Usage
-----
* Faker::Name.name => "Christophe Bartell"
* Faker::Internet.email => "kirsten.greenholt@corkeryfisher.info"

Usage with Rails
----------------
If you want to change your locale with Rails from the default of :en, change
config/application.rb, setting config.i18n.locale to whatever locale you
want.  Change locale rather than default_locale (as suggested by the comments
in that file) so that I18n's fallbacks will work properly and Faker can use
the formats and data in en.yml (if there is no Faker localization for your
locale).  If you'd prefer to set default_locale rather than locale, then
you'll also need to add config.i18n.fallbacks.defaults = [:en] to your
configuration to make the fallbacks work for Faker.

Customization
------------
Since you may want to make addresses and other types of data look different
depending on where in the world you are (US postal codes vs. UK postal codes,
for example), Faker uses the I18n gem to store strings (like state names) and
formats (US postal codes are NNNNN while UK postal codes are AAN NAA),
allowing you to get different formats by switching locales.  Just set
Faker::Config.locale to the locale you want, and Faker will take care of the
rest.

Contributing
------------
If you'd like to contribute code or formats/data for another locale, fork
the project at [github](https://github.com/stympy/faker), make your changes,
then send a pull request.

Contact
-------
Comments and feedback are welcome. Send an email to Benjamin Curtis via the [google group](http://groups.google.com/group/ruby-faker).

License
-------
This code is free to use under the terms of the MIT license.


