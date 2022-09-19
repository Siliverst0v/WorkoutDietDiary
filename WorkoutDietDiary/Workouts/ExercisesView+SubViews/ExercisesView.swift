//
//  ExercisesView.swift
//  WorkoutDietDiary
//
//  Created by Анатолий Силиверстов on 19.09.2022.
//

import SwiftUI
import RealmSwift

struct ExercisesView: View {
    @ObservedResults(SelfExercise.self) var selfExercises
    @EnvironmentObject var realmManager: RealmManager
    @FocusState var isFocused: Bool?
    
    @State var choosenExercises: [ChoosenExercise] = []
    @State var date: Date
    
    @Binding var choosenExerciseGroups: [ExerciseGroup]
    @Binding var workoutsIsActive: Bool
    
    var updatableWorkout: Workout?
    
    var body: some View {
        
        ScrollView(.vertical, showsIndicators: false) {
            ForEach($choosenExerciseGroups, id: \.id) {exerciseGroup in
                TextField("", text: exerciseGroup.title)
                    .font(.title)
                    .foregroundColor(.customRed)
                    .disabled(true)
                    .padding()
                Divider()
                VStack {
                    Text("Мои упражнения")
                        .font(.custom("title", size: 20))
                        .foregroundColor(.customBlue)
                }
                .frame(maxWidth: UIScreen.main.bounds.size.width - 40, alignment: .leading)
                Divider()
                AddSelfExerciseButton(
                    isFocused: _isFocused,
                    image: exerciseGroup.icon,
                    exerciseGroupName: exerciseGroup.title)
                
                ForEach(selfExercises.where {$0.exerciseGroup == exerciseGroup.title.wrappedValue}, id: \.id) {selfExercise in
                    SelfExerciseButton(
                        selfExercise: selfExercise,
                        isFocused: _isFocused,
                        image: exerciseGroup.icon,
                        choosenExercises: $choosenExercises,
                        date: $date)
                }
                Divider()
                VStack {
                    Text("Упражнения")
                        .font(.custom("title", size: 20))
                        .foregroundColor(.customBlue)
                }
                .frame(maxWidth: UIScreen.main.bounds.size.width - 40, alignment: .leading)
                Divider()
                ForEach(exerciseGroup.exercisesToDisplay, id: \.self) {exercise in
                    ExerciseButton(
                        isFocused: _isFocused,
                        title: exercise,
                        image: exerciseGroup.icon,
                        choosenExercises: $choosenExercises,
                        date: $date)
                }
            }
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button { addWorkout() } label: {
                    Text("Готово")
                }
            }
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
    }
}

extension ExercisesView {
    
    private func addWorkout() {
        if let workout = updatableWorkout {
            realmManager.updateWorkout(
                id: workout.id,
                date: date,
                exerciseGroups: choosenExerciseGroups.map {$0.title},
                choosenExercises: choosenExercises)
        } else {
            realmManager.addWorkout(
                date: date,
                exerciseGroups: choosenExerciseGroups.map {$0.title},
                choosenExercises: choosenExercises)
        }
        workoutsIsActive = false
    }
}

struct ExercisesView_Previews: PreviewProvider {
    static var previews: some View {
        ExercisesView(
            date: Date(),
            choosenExerciseGroups: .constant(ExerciseGroup.getMocExercises()),
            workoutsIsActive: .constant(false))
        .environmentObject(RealmManager())
    }
}
