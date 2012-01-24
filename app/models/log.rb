# AntiMap Log Object
class Log
  include MongoMapper::Document
  many :points
  one :path
  
  key :filename, String
  key :minimum_speed, Float
  key :maximum_speed, Float
  key :average_speed, Float
  key :total_distance, Float
  key :total_time_in_hours, String
  key :total_time_in_minutes, String
  timestamps!
    
  def initialize(args={})
    self.filename = args[:filename]
    
    if args[:points] and args[:points].any?
      args[:points].each do |point|
        self.points << Point.new(
          :latitude => point[0],
          :longitude => point[1],
          :compass => point[2],
          :speed => point[3],
          :distance => point[4],
          :time => point[5]
        )
      end
    end
        
    # Index these measures instead of calculating them on the spot each time
    self.minimum_speed = calculate_minimum_speed
    self.maximum_speed = calculate_maximum_speed
    self.average_speed = calculate_average_speed
    self.total_distance = calculate_total_distance
    self.total_time_in_hours = calculate_total_time_in_hours
    
    # Creates the path object to generate the Google Map Polyline data for googlemaps4rails
    if self.points.any?
      self.path = Path.new(
        :start => {:longitude => self.points.first.longitude, :latitude => self.points.first.latitude},
        :gmap_options => {
          :strokeColor => "#FF0000", 
          :strokeOpacity => 0.8,
          :strokeWeight => 2,
          :fillColor => "#FF0000",
          :fillOpacity => 0.35
        },
        :coordinates => self.points.map{|p| {:lng => p.longitude, :lat => p.latitude}}
      )
    end
  end
  
  private
  
  # Calculates the average speed for the whole trip
  def calculate_average_speed
    speeds = self.points.map(&:speed)
    speeds.inject(:+).to_f / speeds.length
  end
  
  # Calculates the minimum speed
  def calculate_minimum_speed
    self.points.slowest.first.speed if self.points.slowest and self.points.slowest.first and self.points.slowest.first.speed
  end
  
  # Calculates the maximum speed
  def calculate_maximum_speed
    self.points.fastest.first.speed if self.points.fastest and self.points.fastest.first and self.points.fastest.first.speed
  end
  
  # Calculates the total distance travelled
  def calculate_total_distance
    self.points.furtherest.first.distance if self.points.furtherest and self.points.furtherest.first and self.points.furtherest.first.speed
  end
  
  # Calculates the total time elapsed in hours
  def calculate_total_time_in_hours
    last_time = self.points.last(:order => :time.asc).time if self.points.last(:order => :time.asc)
    return unless last_time
    x = last_time / 1000
    seconds = x % 60
    x /= 60
    minutes = x % 60
    x /= 60
    hours = x % 24
    "%02d" % (hours).to_s << ":" << "%02d" % (minutes).to_s << ":" << "%02d" % (seconds).to_s
  end
  
end
