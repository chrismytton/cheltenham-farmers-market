# Cheltenham farmers market dates

Scraper to get the dates of Cheltenham farmers market from [the council's website](https://www.cheltenham.gov.uk/info/24/markets/491/cheltenham_farmers_market).

## Install

This is a Ruby scraper, so you will need to have a recent version of Ruby installed, along with bundler (`gem install bundler`). Then run the following:

    git clone https://github.com/chrismytton/cheltenham-farmers-market
    cd cheltenham-farmers-market
    bundle install

## Usage

Running the scraper will create a `.ics` file at `public/farmers-markets.ics` suitable for adding to most calendar applications. Run the scraper like so:

    ruby scraper.rb
