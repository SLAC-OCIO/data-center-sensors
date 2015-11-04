/**
 * Created by xalg on 11/3/15.
 * All functions and vars in here are related
 * to setting up geometry.
 * Geom, is a global, in that it is a reactive dictionary
 * newW and newH are globals that set the height and width
 * of the objects that use them.
 */
Meteor.startup(function() {
    var geom = new ReactiveDict;

    var updateWindowSize = function () {
        geom.set("width", window.innerWidth);
        geom.set("height", window.innerHeight);
        redrawHeatMap();
    };
    updateWindowSize();
    window.addEventListener("resize", updateWindowSize);

    var windowSize = function () {
        return {
            width: geom.get("width"),
            height: geom.get("height")
        };
    }
    newW = geom.get("width")
    newH = geom.get("height")
})

zoom = d3.behavior.zoom().scale(1 << 12).scaleExtent([ 1 << 9, 1 << 23 ]).translate([ 'newW' / 2, 'newH' / 2 ]).on("zoom", zoomed)

function zoomed() {
/*    var tiles = tile
        .scale(zoom.scale())
        .translate(zoom.translate())
        ();*/

    projection
        .scale(zoom.scale() / 2 / Math.PI)
        .translate(zoom.translate());

    /*var image = layer
        .style(prefix + "transform", matrix3d(tiles.scale, tiles.translate))
        .selectAll(".tile")
        .data(tiles, function(d) { return d; });

    image.exit()
        .remove();

    image.enter().append("img")
        .attr("class", "tile")
        .attr("src", function(d) { return "http://" + ["a", "b", "c"][Math.random() * 3 | 0] + ".tile.openstreetmap.org/" + d[2] + "/" + d[0] + "/" + d[1] + ".png"; })
        .style("left", function(d) { return (d[0] << 8) + "px"; })
        .style("top", function(d) { return (d[1] << 8) + "px"; });*/
}
