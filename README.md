# bloc_tutorial_todo
A Flutter project to showcase clean architecture, bloc pattern and test-driven design.

## Clean Architecture
With clean architecture, there are 3 layers: data layer, domain layer and presentation layer.

### Data Layer
This is the layer where we define the data source, either from APIs or the local database, and specify how we retrieve the data or perform the request.

### Domain Layer
This layer contains crucial business logic. The entity serves as the 'model' that we use within the app, independent of the data sourced from APIs or the local database.

### Presentation Layer
This is the UI of the application. Business logic and UI concerns should be kept separate, adhering to the SOLID principle.

## Bloc
A state management tool can be likened to a river scenario: imagine being upstream, and your friends are downstream. You send boats with colors down the river (emitting events). Your friend picks them up and, based on the color of the boat, inflates balloons of different colors (bloc processing). Now, the sky is filled with balloons, each corresponding to a color (emitting state and triggering UI changes).

### Event
The user interaction emits the corresponding event to the bloc.

### Bloc
Based on the incoming event, process the business logic, emit the corresponding state.

### State
The state of a class determines how the widgets can change or react accordingly.