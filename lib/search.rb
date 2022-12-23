# frozen_string_literal: tru

class Search
  attr_reader :name, :address, :regexp, :valid, :error, :term, :type

  MISSING_BOTH = "Missing either the name or address argument"
  HAS_BOTH = "Cannot search by both name and address"

  def initialize(options)
    @name = options[:name]
    @address = options[:address]
    @regexp = options[:regexp]

    validate!

    set_term_and_type
  end

  def address?
    !!address
  end

  def name?
    !!name
  end

  def valid?
    !!valid
  end

  def invalid?
    !valid?
  end

  private

  def validate!
    @valid = true

    name_or_address_present?
    validate_name
    validate_address
  end

  def name_or_address_present?
    unless name || address
      fail_validation(MISSING_BOTH)
    end

    unless !!name ^ !!address
      fail_validation(HAS_BOTH)
    end
  end

  def set_term_and_type
    @term = name || address
    @type = name? ? :name : :address
  end

  def fail_validation(message)
    @valid = false
    @error = message
  end

  def validate_name
  end

  def validate_address
  end
end
