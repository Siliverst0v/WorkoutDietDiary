//
//  WorkoutsView.swift
//  WorkoutDietDiary
//
//  Created by Анатолий Силиверстов on 19.09.2022.
//

import SwiftUI
import RealmSwift

struct WorkoutsView: View {
    
    @StateObject var realmManager = RealmManager()
    
    @ObservedResults(Workout.self, sortDescriptor: SortDescriptor(keyPath: "date", ascending: false) ) var workouts
    @State var showConfirm: Bool = false
    
    @State var workoutsIsActive = false
    @State var selection: String? = nil
    @State var workoutSelection: ObjectId? = ObjectId()
    
    var body: some View {
        NavigationView {
            ScrollView(.vertical, showsIndicators: false) {
                ForEach(workouts, id: \.id) {workout in
                    VStack(alignment: .trailing, spacing: 0) {
                        
                        DeleteWorkoutButton(workout: workout)
                        .environmentObject(realmManager)
                        Button { workoutSelection = workout.id }
                    label: {
                        ZStack {
                            HStack {
                                VStack {
                                    Text("\(formatDate(date: workout.date)) \(getDayName(date: workout.date))")
                                        .foregroundColor(.customRed)
                                        .font(.headline)
                                        .multilineTextAlignment(.center)
                                        .padding(5)
                                    ForEach(workout.exerciseGroups, id: \.self) { exerciseGroupName in
                                        Text(exerciseGroupName)
                                            .foregroundColor(.customBlue)
                                            .font(.headline)
                                            .padding(5)
                                    }
                                }
                                .padding()
                                WorkoutBodyView(workout: workout)
                            }
                            NavigationLink("",
                                           tag: workout.id,
                                           selection: $workoutSelection) {
                                
                                DetailWorkoutView(workout: workout)
                                    .environmentObject(realmManager)
                            }
                        }
                    }
                    .buttonStyle(WorkoutButtonStyle())
                    }
                    .padding(.horizontal)
                    .padding(.vertical, 5)
                }
            }
            .navigationTitle("Дневник тренировок")
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
                            ChooseExercisesView(workoutsIsActive: $workoutsIsActive)
                                .environmentObject(realmManager)
                        }
                    }
                }
            }
        }
    }
}

struct Workouts_Previews: PreviewProvider {
    static var previews: some View {
        WorkoutsView()
            .environmentObject(RealmManager())
    }
}
