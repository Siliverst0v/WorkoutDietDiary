//
//  DeleteWorkoutButton.swift
//  WorkoutDietDiary
//
//  Created by Анатолий Силиверстов on 19.09.2022.
//

import SwiftUI
import RealmSwift

struct DeleteWorkoutButton: View {
    @EnvironmentObject var realmManager: RealmManager
    
    @State var showConfirm: Bool = false
    @ObservedRealmObject var workout: Workout
    
    var body: some View {
        HStack(spacing: 0) {
            Button(action: { showConfirm = true }) {
                Text("x")
                    .foregroundColor(.customRed)
                    .font(.system(size: 20))
            }
            .confirmationDialog("Удалить тренировку?", isPresented: $showConfirm, titleVisibility: .visible, actions: {
                Button("Удалить", role: .destructive) {
                    deleteWorkout(workout: workout)
                }
            })
            .buttonStyle(DeleteButtonsStyle())
            .padding(.trailing)
        }
    }
}

extension DeleteWorkoutButton {
    
    private func deleteWorkout(workout: Workout) {
        realmManager.deleteWorkout(id: workout.id)
    }
}

struct WorkoutsView_Previews: PreviewProvider {
    static var previews: some View {
        DeleteWorkoutButton(
            workout: Exercises.shared.getMocExercise()
        )
        .environmentObject(RealmManager())
    }
}
