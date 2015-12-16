//see flowRouter's documentation
FlowRouter.route('/', {
    action: function(params, queryParams) {
        BlazeLayout.render("mainLayout", {
            content: "home",
            dialog: queryParams.dialog,
        });
    }
});

FlowRouter.route('/heatmap', {
    action: function(params, queryParams) {
        BlazeLayout.render("heatmap", {
            content: "heatmap"
        });
    }
});

FlowRouter.route('/table', {
    action: function(params, queryParams) {
        BlazeLayout.render("mainLayout", {
            content: "sensor_table",
            dialog: queryParams.dialog,
        });
    }
});

FlowRouter.route('/sensor/:id/timechart', {
    action: function(params,queryParams){
        BlazeLayout.render("sensor_timechart",{
            content: "sensor_timechart",
            params: queryParams.content,
        });
    }
});
