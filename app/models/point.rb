class Point
  # FIXME: shouldn't it be an EmbeddedDocument?
  include MongoMapper::Document
  
  key :latitude, Float
  key :longitude, Float
  key :compass, Integer
  key :speed, Float
  key :distance, Float
  key :time, Integer
  
  belongs_to :log
  
  scope :fastest, :order => "speed DESC", :limit => 1
  scope :slowest, :order => "speed ASC", :limit => 1
  scope :furtherest, :order => "distance DESC", :limit => 1
  scope :latest, :order => "time DESC", :limit => 1
  
end
