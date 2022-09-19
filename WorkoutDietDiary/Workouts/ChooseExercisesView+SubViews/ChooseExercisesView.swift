//
//  ChooseExercisesView.swift
//  WorkoutDietDiary
//
//  Created by Анатолий Силиверстов on 19.09.2022.
//

import SwiftUI
import RealmSwift

struct ChooseExercisesView: View {
    @EnvironmentObject var realmManager: RealmManager
    
    @State var exercisesToDisplay: [ExerciseGroup] = []
    @State var date: Date = Date()
    @State var chooseViewIsActive = false
    @State var muscleGroups = Exercises.shared
    
    @Binding var workoutsIsActive: Bool
    
    var updatableWorkout: Workout?
        
    let columns = [GridItem(.adaptive(minimum: 110))]
    
    var body: some View {
            VStack {
                if updatableWorkout == nil {
                Spacer()
                DatePicker("Дата тренировки", selection: $date, displayedComponents: .date)
                    .id(date)
                    .environment(\.locale, Locale.init(identifier: "ru"))
                    .datePickerStyle(.compact)
                    .foregroundColor(.customRed)
                    .font(.headline)
                    .padding(5)
                    .overlay(
                        RoundedRectangle(cornerRadius: 11)
                            .stroke(Color.gray, lineWidth: 0.3)
                    )
                    .frame(width: UIScreen.main.bounds.size.width - 40)
                }
                Spacer()
                    Text("Группы упражнений")
                        .foregroundColor(.customRed)
                        .fontWeight(.semibold)
                        .padding(10)
                        .overlay(
                            RoundedRectangle(cornerRadius: 11)
                                .stroke(Color.gray, lineWidth: 0.3)
                        )
                    Spacer()
                
                LazyVGrid(columns: columns, spacing: 30) {
                    ExerciseGroupButtonView(
                        exercisesToDisplay: $exercisesToDisplay,
                        exerciseGroup: ExerciseGroup(
                            title: "Грудь",
                            icon: "chest",
                            exercisesToDisplay: muscleGroups.chest))
                    ExerciseGroupButtonView(
                        exercisesToDisplay: $exercisesToDisplay,
                        exerciseGroup: ExerciseGroup(
                            title: "Плечи",
                            icon: "shoulders",
                            exercisesToDisplay: muscleGroups.shoulders))
                    ExerciseGroupButtonView(
                        exercisesToDisplay: $exercisesToDisplay,
                        exerciseGroup: ExerciseGroup(
                            title: "Спина",
                            icon: "back",
                            exercisesToDisplay: muscleGroups.back))
                    ExerciseGroupButtonView(
                        exercisesToDisplay: $exercisesToDisplay,
                        exerciseGroup: ExerciseGroup(
                            title: "Бицепс",
                            icon: "biceps",
                            exercisesToDisplay: muscleGroups.biceps))
                    ExerciseGroupButtonView(
                        exercisesToDisplay: $exercisesToDisplay,
                        exerciseGroup: ExerciseGroup(
                            title: "Трицепс",
                            icon: "triceps",
                            exercisesToDisplay: muscleGroups.triceps))
                    ExerciseGroupButtonView(
                        exercisesToDisplay: $exercisesToDisplay,
                        exerciseGroup: ExerciseGroup(
                            title: "Ноги",
                            icon: "legs",
                            exercisesToDisplay: muscleGroups.legs))
                    ExerciseGroupButtonView(
                        exercisesToDisplay: $exercisesToDisplay,
                        exerciseGroup: ExerciseGroup(
                            title: "Пресс",
                            icon: "abs",
                            exercisesToDisplay: muscleGroups.abs))
                    ExerciseGroupButtonView(
                        exercisesToDisplay: $exercisesToDisplay,
                        exerciseGroup: ExerciseGroup(
                            title: "Предплечья",
                            icon: "forearms",
                            exercisesToDisplay: muscleGroups.forearms))
                    ExerciseGroupButtonView(
                        exercisesToDisplay: $exercisesToDisplay,
                        exerciseGroup: ExerciseGroup(
                            title: "Кардио",
                            icon: "cardio",
                            exercisesToDisplay: muscleGroups.cardio))
                }
                Spacer()
                BodyView(exercisesToDisplay: $exercisesToDisplay)
                Spacer()
        }
            .navigationBarTitleDisplayMode(.inline)
            .background(
                NavigationLink(isActive: $chooseViewIsActive, destination: {
                    ExercisesView(
                        date: date,
                        choosenExerciseGroups: $exercisesToDisplay,
                        workoutsIsActive: $workoutsIsActive,
                        updatableWorkout: updatableWorkout)
                    .environmentObject(realmManager)
                }, label: {
                    EmptyView()
                })
                .isDetailLink(false)
            )
            .toolbar {
                Button {
                    chooseViewIsActive = true
                } label: {
                    Text("Далее")
                }
                .opacity(exercisesToDisplay.isEmpty ? 0 : 1)
                .disabled(exercisesToDisplay.isEmpty)
            }
    }
}

struct ChooseExercisesGroupView_Previews: PreviewProvider {
    static var previews: some View {
        ChooseExercisesView(
            workoutsIsActive: .constant(false))
            .previewInterfaceOrientation(.portrait)
            .environmentObject(RealmManager())
    }
}
