//
//  WorkoutBodyView.swift
//  WorkoutDietDiary
//
//  Created by Анатолий Силиверстов on 19.09.2022.
//

import SwiftUI
import RealmSwift

struct WorkoutBodyView: View {
    @ObservedRealmObject var workout: Workout
    
    var body: some View {
            ZStack {
                Image("body")
                    .resizable()
                Image("backBody")
                    .resizable()
                    .opacity(workout.exerciseGroups.contains("Спина") ? 1 : 0)
                Image("chestBody")
                    .resizable()
                    .opacity(workout.exerciseGroups.contains("Грудь") ? 1 : 0)
                Image("bicepsBody")
                    .resizable()
                    .opacity(workout.exerciseGroups.contains("Бицепс") ? 1 : 0)
                Image("tricepsBody")
                    .resizable()
                    .opacity(workout.exerciseGroups.contains("Трицепс") ? 1 : 0)
                Image("absBody")
                    .resizable()
                    .opacity(workout.exerciseGroups.contains("Пресс") ? 1 : 0)
                Image("forearmsBody")
                    .resizable()
                    .opacity(workout.exerciseGroups.contains("Предплечья") ? 1 : 0)
                Image("legsBody")
                    .resizable()
                    .opacity(workout.exerciseGroups.contains("Ноги") ? 1 : 0)
                Image("shouldersBody")
                    .resizable()
                    .opacity(workout.exerciseGroups.contains("Плечи") ? 1 : 0)
                Image("cardioBody")
                    .resizable()
                    .opacity(workout.exerciseGroups.contains("Кардио") ? 1 : 0)
            }
            .frame(height: width > 380 ? 160 : 120)
            .padding()
    }
}

struct WorkoutBodyView_Previews: PreviewProvider {
    static var previews: some View {
        WorkoutBodyView(workout: Exercises.shared.getMocExercise())
    }
}
