//
//  WorkoutsView.swift
//  WorkoutDietDiary
//
//  Created by Анатолий Силиверстов on 19.09.2022.
//

import SwiftUI
import RealmSwift

struct WorkoutsView: View {
    init() {
        UITextView.appearance().backgroundColor = .clear
    }
    
    @StateObject var realmManager = RealmManager()
    
    @ObservedResults(Workout.self, sortDescriptor: SortDescriptor(keyPath: "date", ascending: false) ) var workouts
    @State var showConfirm: Bool = false
    
    @State var workoutsIsActive = false
    @State var selection: String? = nil
    @State var workoutSelection: ObjectId? = ObjectId()
    
    var body: some View {
        NavigationView {
            if workouts.isEmpty {
                NavigationLink(tag: workoutsIsActive ? "ChooseExerciseView" : "", selection: $selection) {
                    ChooseExercisesView(workoutsIsActive: $workoutsIsActive)
                        .environmentObject(realmManager)
                } label: {
                    
                    ZStack {
                        RoundedRectangle(cornerRadius: 11)
                            .stroke(Color.gray, lineWidth: 0.3)
                        
                        VStack(alignment: .center) {
                            Spacer()
                            Image(systemName: "plus.circle")
                                .resizable()
                                .frame(width: 50, height: 50)
                                .foregroundColor(.customBlue)
                            Spacer()
                            Text("Добавить первую тренировку")
                                .multilineTextAlignment(.center)
                                .foregroundColor(.customRed)
                                .font(.custom("semibold", size: 24))
                            Spacer()
                        }
                    }
                    .frame(width: UIScreen.main.bounds.size.width - 40, height: 150, alignment: .center)
                }
                .buttonStyle(WorkoutButtonStyle())
                
                
            } else {
                ScrollView(.vertical, showsIndicators: false) {
                    ForEach(workouts, id: \.id) {workout in
                        VStack(alignment: .trailing, spacing: 0) {
                            
                            DeleteWorkoutButton(
                                workout: workout)
                                .environmentObject(realmManager)
                            Button { workoutSelection = workout.id }
                        label: {
                            ZStack {
                                HStack {
                                    VStack {
                                        Text(workoutsDate(workout: workout))
                                            .foregroundColor(.customRed)
                                            .font(.headline)
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
}

extension WorkoutsView {
    
    private func workoutsDate(workout: Workout) -> String {
        let df = DateFormatter()
        df.dateFormat = "dd.MM.yyyy"
        return df.string(from: workout.date)
    }
}

struct Workouts_Previews: PreviewProvider {
    static var previews: some View {
        WorkoutsView()
            .environmentObject(RealmManager())
    }
}
