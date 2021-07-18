# frozen_string_literal: true

# Carriage Class
class Carriage
  include CompanyName
  attr_accessor :type, :number

  def initialize(number)
    @number = number

    begin
      validate!
    rescue RuntimeError => e
      puts e.message
    end
  end

  def valid?
    validate!
    true
  rescue StandardError
    false
  end

  protected

  def validate!
    raise 'Number can`t be nil' if number.nil?
  end
end
