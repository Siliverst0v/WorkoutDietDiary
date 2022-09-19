//
//  DetailWorkoutView.swift
//  WorkoutDietDiary
//
//  Created by Анатолий Силиверстов on 19.09.2022.
//

import SwiftUI
import RealmSwift

struct DetailWorkoutView: View {
    
    @EnvironmentObject var realmManager: RealmManager
    @ObservedRealmObject var workout: Workout
    @FocusState var isFocused: Bool?
    @State var workoutsIsActive = false
    @State var selection: String? = nil
    
    var body: some View {
        
        ScrollView {
            ForEach(workout.choosenExercises, id: \.id) { choosenExercise in
                ChoosenExerciseButtonView(
                    isFocused: _isFocused,
                    choosenExercise: choosenExercise)
                .environmentObject(realmManager)
            }
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    HStack{
                        Spacer()
                        Button {
                            isFocused = nil
                        } label: {
                            Text("Готово")
                        }
                    }
                }
            }
            .padding()
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    workoutsIsActive = true
                    self.selection = "ChooseExerciseView"
                    
                } label: {
                    Image(systemName: "plus.circle")
                    NavigationLink("",
                                   tag: workoutsIsActive ? "ChooseExerciseView" : "",
                                   selection: $selection) {
                        ChooseExercisesView(workoutsIsActive: $workoutsIsActive, updatableWorkout: workout)
                            .environmentObject(realmManager)
                    }
                }
            }
        }
    }
}


struct DetailWorkoutView_Previews: PreviewProvider {
    static var previews: some View {
        DetailWorkoutView(workout: Exercises.shared.getMocExercise())
            .environmentObject(RealmManager())
    }
}
