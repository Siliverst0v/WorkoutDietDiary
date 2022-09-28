//
//  BodyView.swift
//  WorkoutDietDiary
//
//  Created by Анатолий Силиверстов on 19.09.2022.
//

import SwiftUI

struct BodyView: View {
    @Binding var exercisesToDisplay: [ExerciseGroup]
    
    var body: some View {
        ZStack {
            Image("body")
                .resizable()
            Image("backBody")
                .resizable()
                .opacity(showIcons(muscleGroupName: "Спина") ? 1 : 0)
            Image("chestBody")
                .resizable()
                .opacity(showIcons(muscleGroupName: "Грудь") ? 1 : 0)
            Image("bicepsBody")
                .resizable()
                .opacity(showIcons(muscleGroupName: "Бицепс") ? 1 : 0)
            Image("tricepsBody")
                .resizable()
                .opacity(showIcons(muscleGroupName: "Трицепс") ? 1 : 0)
            Image("absBody")
                .resizable()
                .opacity(showIcons(muscleGroupName: "Пресс") ? 1 : 0)
            Image("forearmsBody")
                .resizable()
                .opacity(showIcons(muscleGroupName: "Предплечья") ? 1 : 0)
            Image("legsBody")
                .resizable()
                .opacity(showIcons(muscleGroupName: "Ноги") ? 1 : 0)
            Image("shouldersBody")
                .resizable()
                .opacity(showIcons(muscleGroupName: "Плечи") ? 1 : 0)
            Image("cardioBody")
                .resizable()
                .opacity(showIcons(muscleGroupName: "Кардио") ? 1 : 0)
        }
        .frame(width: width, height: width > 380 ? 300 : 200, alignment: .center)
        .padding(.vertical, 5)
        .overlay(
            RoundedRectangle(cornerRadius: 11)
                .stroke(Color.gray, lineWidth: 0.3)
        )
    }
}

extension BodyView {
    
    func showIcons(muscleGroupName: String) -> Bool {
        if exercisesToDisplay.filter({$0.title == muscleGroupName}).first != nil {
            return true
        }
        return false
    }
}

struct BodyView_Previews: PreviewProvider {
    static var previews: some View {
        BodyView(exercisesToDisplay: .constant([
                ExerciseGroup(
                    title: "Кардио",
                    icon: "cardio",
                    exercisesToDisplay: Exercises.shared.cardio)])
        )
    }
}
