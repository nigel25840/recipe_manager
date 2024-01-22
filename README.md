# recipe_management

A new Flutter project.

## About this project
- AppFacade serves as a data source for both local and remote data. 
- Behind AppFacade is LocalRepository and APIRepository which are accessible only through the AppFacade.
- App uses SharedPreferences as a local data store.
## With more time
- Add RouteSettings file and use an app router to manage navigation routes. This would be most appropriate if the app grows in size and complexity.
- Add pull-to-refresh on recipes view
- Make a default AppBar to be reused
- Add functionality to select all ingredients for search
- Add functionality to delete all in-stock ingredients
- Add a more robust NoSQL persistence solution such as Hive
- Create mocks of LocalRepository and ApiRepository instead of mocking AppFacade
- Add Mockoon to replace mocks for widget testing. Allows for easy mocking of endpoint responses.
