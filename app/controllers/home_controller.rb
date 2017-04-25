require 'yahoofinance'


class HomeController < ApplicationController
  def index
    # Set the type of quote we want to retrieve.
  # Available type are:
  #  - YahooFinance::StandardQuote
  #  - YahooFinance::ExtendedQuote
  #  - YahooFinance::RealTimeQuote


  # Set the symbols for which we want to retrieve quotes.
  # You can include more than one symbol by separating
  # them with a ',' (comma).


  # Get the quotes from Yahoo! Finance.  The get_quotes method call
  # returns a Hash containing one quote object of type "quote_type" for
  # each symbol in "quote_symbols".  If a block is given, it will be
  # called with the quote object (as in the example below).



  # You can get the same effect using the quote specific method.

  end
end
