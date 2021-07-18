# frozen_string_literal: true

# Station Class
class Station
  include InstanceCounter

  attr_accessor :trains
  attr_reader :name

  # rubocop:disable Style/ClassVars
  @@stations = []
  # rubocop:enable Style/ClassVars

  def self.all
    @@stations
  end

  def initialize(name)
    @name = name
    @trains = []
    @@stations << self
    register_instance(self.class)
    exceptions!
  end

  def add_train(train)
    trains << train
  end

  def delete_train(train)
    @trains = @trains.reject { |item| item.number == train.number }
    @trains
  end

  def all_trains_by_type(type)
    trains.filter { |train| train.type == type }
  end

  def type_count(type)
    train_by_type(type).size
  end

  def valid?
    validate!
    true
  rescue StandardError
    false
  end

  def show_trains_on_station
    @trains.each(&block)
  end

  protected

  def exceptions!
    validate!
  rescue RuntimeError => e
    puts e.message
  end

  def validate!
    raise 'Station name cannot be empty' if name.nil?
    raise 'Station name must have 3 symbols' if name.lenght < 3
  end
end
