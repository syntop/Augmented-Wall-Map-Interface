class TiledScrollView < UIScrollView
  def self.layerClass
    return CATiledLayer
  end
end