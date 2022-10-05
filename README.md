
Workout and Diet Diary App

Built on the SwiftUI framework, data storage and deletion is implemented via RealmSwift.

The first part of the application allows you to create a workout by selecting muscle groups and exercises for them:

    * When you click on a group, it is highlighted on the human model
    
    * The exercise is opened by clicking on it and you can immediately fill in the fields
    
    * The "memories" button on the right allows you to see the results of this exercise in past workouts,
    you do not need to remember and search.

    * You can also leave a note on the exercise
    
![ChooseExerciseScreen2](https://user-images.githubusercontent.com/94259002/194171893-b12ef21f-76f2-4118-bc18-15984bc028bc.png)
![ExercisesScreen](https://user-images.githubusercontent.com/94259002/194169209-11dfb3da-31a9-4d85-b13b-49cea1b03461.png)


When the workout is created, it will appear on the main screen.

    * If needed, it can be removed.
    
    * When pressed, we go to the detailed view and see all the selected exercises, 
    they can be edited and deleted.
    
![WorkoutScreen](https://user-images.githubusercontent.com/94259002/176560989-37edd9ea-3b98-4e1e-a287-37fea8137a63.png)
![DetailWorkoutScreen](https://user-images.githubusercontent.com/94259002/176560997-6aea296b-3894-46b6-863c-c4711eb4a8ba.png)


The second part of the application is a calorie diary.

    * Just add a meal, fill in the name and number of calories, 
    and the application calculates the calories for the day.

![CaloriesScreen](https://user-images.githubusercontent.com/94259002/176561913-9c7744c8-01d9-4511-b668-a5c2a13b934b.png) 
![AddFoodScreen](https://user-images.githubusercontent.com/94259002/176562004-57ac5975-9874-4b62-9881-cfb5db498568.png)
