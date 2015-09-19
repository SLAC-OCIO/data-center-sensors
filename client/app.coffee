
Router.route '/', () ->
  @render('heatmap')
Router.route '/list', () ->
  @render('sensor_table')
  
