
define [
  "underscore",
  "common/collection",
  "renderer/properties",
  "./marker",
], (_, Collection, Properties, Marker) ->

  class XView extends Marker.View

    _properties: ['line']

    _render: (ctx, indices, glyph_props, sx=@sx, sy=@sy, size=@size) ->
      for i in indices

        if isNaN(sx[i] + sy[i] + size[i])
          continue

        r = size[i]/2
        ctx.beginPath()
        ctx.moveTo(sx[i]-r, sy[i]+r)
        ctx.lineTo(sx[i]+r, sy[i]-r)
        ctx.moveTo(sx[i]-r, sy[i]-r)
        ctx.lineTo(sx[i]+r, sy[i]+r)

        if glyph_props.line_properties.do_stroke
          glyph_props.line_properties.set_vectorize(ctx, i)
          ctx.stroke()

  class X extends Marker.Model
    default_view: XView
    type: 'X'

    display_defaults: ->
      return _.extend {}, super(), @line_defaults

  class Xs extends Collection
    model: X

  return {
    Model: X
    View: XView
    Collection: new Xs()
  }
