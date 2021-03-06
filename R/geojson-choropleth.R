# Source https://github.com/timwis/leaflet-choropleth
geoJSONChoroplethDependency <- function() {
  list(
    htmltools::htmlDependency(
      "geojson-choropleth",version = "1.1.2",
      system.file("htmlwidgets/lib/geojson-choropleth", package = "leaflet.extras"),
      script = c("choropleth.js","geojson-choropleth-bindings.js")
    )
  )
}

#' @param map The leaflet map
#' @param geojson either as a list or a string
#' @param layerId a unique ID for the layer
#' @param group the group this layer will be added to
#' @param valueProperty The property to use for coloring
#' @param popupProperty The property to use for popup content
#' @param labelProperty The property to use for labelling.
#' @param scale The scale to use from chroma.js
#' @param steps number of breakes
#' @param mode q for quantile, e for equidistant, k for k-means
#' @param colors overrides scale with manual colors
#' @param stroke whether to draw stroke along the path (e.g. the borders of
#'   polygons or circles)
#' @param color stroke color
#' @param weight stroke width in pixels
#' @param opacity stroke opacity (or layer opacity for tile layers)
#'   circles)
#' @param fillOpacity fill opacity
#' @param dashArray a string that defines the stroke
#'   \href{https://developer.mozilla.org/en/SVG/Attribute/stroke-dasharray}{dash
#'   pattern}
#' @param smoothFactor how much to simplify the polyline on each zoom level
#'   (more means better performance and less accurate representation)
#' @param noClip whether to disable polyline clipping
#' @rdname geojson-choropleth
#' @export
addGeoJSONChoropleth = function(
  map, geojson, layerId = NULL, group = NULL,
  valueProperty,
  labelProperty,
  popupProperty,
  scale = c('white','red'),
  steps =5,
  mode = 'q',
  colors = NULL,
  stroke = TRUE,
  color = "#03F",
  weight = 1,
  opacity = 0.5,
  #fill = TRUE,
  #fillColor = color,
  fillOpacity = 0.2,
  dashArray = NULL,
  smoothFactor = 1.0,
  noClip = FALSE
) {
  map$dependencies <- c(map$dependencies,
                        geoJSONChoroplethDependency())
  options = list(
    valueProperty=valueProperty,
    popupProperty=popupProperty,
    labelProperty=labelProperty,
    scale=scale,
    steps=steps,
    mode=mode,
    colors=colors,
    stroke=stroke,
    color=color,
    weight=weight,
    opacity=opacity,
    #fill=fill,
    #fillColor=fillColor,
    fillOpacity=fillOpacity,
    dashArray=dashArray,
    smoothFactor=smoothFactor,
    noClip=noClip
  )
  leaflet::invokeMethod(
    map, leaflet::getMapData(map), 'addGeoJSONChoropleth',
    geojson, layerId, group, options)
}

#' removes the geojson choropleth.
#' @rdname geojson-choropleth
#' @export
removeGeoJSONChoropleth = function(map, layerId) {
    leaflet::invokeMethod(map, leaflet::getMapData(map), 'removeGeoJSONChoropleth', layerId)
}

#' clears the geojson choropleth.
#' @rdname geojson-choropleth
#' @export
clearGeoJSONChoropleth = function(map) {
    leaflet::invokeMethod(map, NULL, 'clearGeoJSONChoropleth')
}
