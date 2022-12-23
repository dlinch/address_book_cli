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
    @entries.select(&address_proc(*args))
  end

  def format_results(results)
    results.map do |key, value|
      <<-HEREDOC
        Name: #{key}
        Address: #{value}
      HEREDOC
    end.join("\n")
  end

  def name_lookup(*args)
    @entries.select(&name_proc(*args))
  end

  def address_proc(term, fuzzy)
    fuzzy_match = -> (_, value) { Regexp.new(term, Regexp::IGNORECASE).match?(value) }
    exact_match = -> (_, value) { value == term }
    fuzzy ? fuzzy_match : exact_match
  end

  def name_proc(term, fuzzy)
    fuzzy_match = -> (key, _) { Regexp.new(term, Regexp::IGNORECASE).match?(key) }
    exact_match = -> (key, _) { key == term }
    fuzzy ? fuzzy_match : exact_match
  end
end
