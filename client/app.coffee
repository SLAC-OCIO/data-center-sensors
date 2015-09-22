
Router.route '/', () ->
  @render('heatmap')
Router.route '/list', () ->
  @render('sensor_table')
  
Router.route '/sensor/:id/timechart', () ->
  @render('sensor_timechart')