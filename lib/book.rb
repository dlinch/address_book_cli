require 'json'

class Book
  attr_accessor :fuzzy

  def self.lookup(search)
    new(search).lookup
  end

  def initialize(search)
    file = File.read('addresses.json')
    @entries = JSON.parse(file)

    @fuzzy = search.regexp
    @term =  search.term
    @type = search.type
  end

  def lookup
    results = self.send(:"#{@type}_lookup", @term, @fuzzy)

    format_results(results)
  end

  def address_lookup(*args)
    @entries.select(&match_proc(*args))
  end

  def format_results(results)
    results.map do |key, value|
      <<-HEREDOC
        Name: #{key}
        Address: #{valu}
      HEREDOC
    end.join("\n")
  end

  def name_lookup(*args)
    @entries.invert.select(&match_proc(*args)).invert
  end

  def match_proc(term, fuzzy)
    fuzzy_match = -> (key, value) { Regexp.new(term, Regexp::IGNORECASE).match?(value) }
    exact_match = -> (key, value) { value == term }
    fuzzy ? fuzzy_match : exact_match
  end
end
