# test_color_project

Test project for Solid Software.

## description

There are two datasources with color generation:
  - Local DataSource => get random color from Colors.primaries 
  - Remote DataSource => get random color from API "http://www.colr.org/json/color/random" 
When user has no connection app will use Local DataSource. Otherwise app will send get 
request to the API.

dependencies:
  - equatable
  - flutter_bloc
  - dartz
  - get_it
  - http
  - data_connection_checker
  - connectivity

## issue

Flutter web doesn't work properly with [http.Client] and chosen API. Therefore 
in web version API call is not supported. Now In web version you can just use
[LocalColorDataSource].


