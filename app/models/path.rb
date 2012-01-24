#Google Maps Path for encoded polyline
class Path
  # FIXME: shouldn't it be an EmbeddedDocument?
  include MongoMapper::Document
  
  key :start, Hash
  key :coordinates, Array  
  key :gmap_options, Hash
  # Available google map options are:
  #   :strokeColor, String, "#FF0000"
  #   :strokeOpacity, Float, 0.8
  #   :strokeWeight, Integer, 2
  #   :fillColor, String, "#FF0000"
  #   :fillOpacity, Float, 0.35
  
  belongs_to :log

  def to_polyline
    coordinates.insert(0, {
        :lng => self.start[:longitude],
        :lat => self.start[:latitude]
      }.merge(gmap_options))
  end
  
end
