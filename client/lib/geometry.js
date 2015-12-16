/**
 * Created by xalg on 11/3/15.
 * All functions and vars in here are related
 * to setting up geometry.
 * Geom, is a global, in that it is a reactive dictionary
 * newW and newH are globals that set the height and width
 * of the objects that use them.
 *
 * Create a reactive dictionary
 * on Startup add an event listener that triggers a function to set vars in that dict
 * Set vars according to the window params
 * call the function that redraws the map
 * set globals so we can use those values everywhre.
 */


Meteor.startup(function() {
    dcscope.w = new ReactiveVar(1024);
    dcscope.h = new ReactiveVar(800);
    dcscope.i = new ReactiveVar(0);
    updateWindowSize();
    window.addEventListener("resize", updateWindowSize);
})
function updateWindowSize() {
    updateVars();
    redrawHeatMap(metric);
}

function updateVars(){
    dcscope.w = window.innerWidth;
    dcscope.h = window.innerHeight;
}
//zoom = d3.behavior.zoom().scale(1 << 12).scaleExtent([ 1 << 9, 1 << 23 ]).translate([ 'localW' / 2, 'localH' / 2 ]).on("zoom", zoomed)

//function zoomed() {
//  projection
//        .scale(zoom.scale() / 2 / Math.PI)
//        .translate(zoom.translate());
//}
