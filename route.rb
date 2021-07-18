# frozen_string_literal: true

# Route Class
class Route
  include InstanceCounter
  attr_accessor :stations

  def initialize(start_station, finish_station, number)
    @start_station = start_station
    @finish_station = finish_station
    @number = number
    @stations = []
    register_instance(self.class)

    begin
      validate!
    rescue RuntimeError => e
      puts e.message
    end
  end

  def add_station(station)
    @stations.insert(-2, station)
  end

  def remove_station(station)
    @stations = @stations.reject { |item| item.name == station.name }
    @stations
  end

  def receive_all_routes
    all_routes = @stations
    all_routes.unshift(@start_station) unless all_routes.include?(@start_station)
    all_routes.push(@finish_station) unless all_routes.include?(@finish_station)
    all_routes.uniq
    all_routes
  end

  def assign_train(train)
    @start_station.add_train(train)
  end

  def change_station(train, _type)
    stations_list = receive_all_routes
    new_station = []
    stations_list.each_with_index do |station, _index|
      new_station = new_station_to_train(type) if station.trains.include?(train)
      station.delete_train(train)
    end
    new_station.add_train(train)
  end

  def new_station_to_train(type)
    previous = index - 1
    next_station = index + 1
    end_station = stations_list.length - 1
    if type == :next
      stations_list[next_station > end_station ? end_station : inext_station]
    else
      stations_list[previous.negative? ? 0 : previous]
    end
  end

  def stations_near(train)
    stations_list = receive_all_routes
    stations_list.each_with_index do |station, index|
      next unless station.trains.include?(train)

      puts "Last station: #{stations_list[index - 1].name}" if index - 1 >= 0
      puts "Current station: #{station.name}"
      puts "Next station: #{stations_list[index + 1].name}" if index + 1 < stations_list.length
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
    raise 'Number of route can`t be nil' if number.nil?
    if @start_station.name.length.zero? && @start_station.name.length < 3
      raise 'Start station can`t be nil, and must have min 3 symbols'
    end
    return unless @finish_station.name.length.zero? && @finish_station.name.length < 3

    raise 'Finish station can`t be nil, and must have min 3 symbols'
  end
end
