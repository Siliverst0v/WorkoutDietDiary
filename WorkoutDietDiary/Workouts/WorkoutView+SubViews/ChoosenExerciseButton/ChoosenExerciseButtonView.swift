//
//  ChoosenExerciseButtonView.swift
//  WorkoutDietDiary
//
//  Created by Анатолий Силиверстов on 19.09.2022.
//

import SwiftUI
import RealmSwift

struct ChoosenExerciseButtonView: View {
    @EnvironmentObject var realmManager: RealmManager
    @FocusState var isFocused: Bool?
    @ObservedRealmObject var choosenExercise: ChoosenExercise
    
    @State private var showingSheet = false
    @State private var buttonNotPressed = true
    @State private var backgroundHeight: CGFloat = 283
    @State var previousExercises: [ChoosenExercise] = []
    @State var showConfirm: Bool = false
    
    let buttonWidth = UIScreen.main.bounds.size.width - 40
    
    
    var body: some View {
        if buttonNotPressed {
            NotPressedChoosenExerciseButtonView(
                choosenExercise: choosenExercise,
                buttonNotPressed: $buttonNotPressed,
                icon: choosenExercise.icon,
                title: choosenExercise.title,
                showConfirm: $showConfirm)
        } else {
            ZStack(alignment: .top) {
                ExerciseButtonsBackgroundView(
                    width: buttonWidth,
                    height: backgroundHeight + CGFloat(((choosenExercise.sets.count - 1) * 46)))
                VStack(alignment: .center) {
                    HStack {
                        Spacer()
                        Image(choosenExercise.icon)
                            .resizable()
                            .frame(width: 70, height: 40)
                        Spacer()
                        Text(choosenExercise.title)
                            .fontWeight(.semibold)
                            .font(.system(size: 14))
                            .foregroundColor(.customBlue)
                            .lineLimit(3)
                            .frame(
                                width: buttonWidth - 140,
                                height: 60,
                                alignment: .leading)
                        Spacer()
                        Button(action: { showConfirm = true }) {
                            Image(systemName: "trash")
                                .font(.system(size: 20))
                                .foregroundColor(.customRed)
                                .frame(width: 40,
                                       height: 40,
                                       alignment: .center)
                        }
                        .confirmationDialog("Удалить упражнение?", isPresented: $showConfirm, titleVisibility: .visible, actions: {
                            Button("Удалить", role: .destructive) {
                                deleteChoosenExercise(exercise: choosenExercise)
                            }
                        })
                        .buttonStyle(SimpleButtonStyle())
                        Spacer()
                    }
                    .frame(width: buttonWidth, height: 70, alignment: .center)
                    
                    ChoosenSetsView(
                        choosenExercise: choosenExercise,
                        isFocused: _isFocused,
                        buttonNotPressed: $buttonNotPressed,
                        showingSheet: $showingSheet,
                        previousExercises: $previousExercises)
                    
                    TextEditor(text: $choosenExercise.note)
                        .focused($isFocused, equals: true)
                        .foregroundColor(.customBlue)
                        .lineLimit(2)
                        .frame(width: UIScreen.main.bounds.size.width - 80, height: 80)
                        .cornerRadius(10)
                        .overlay(
                            RoundedRectangle(cornerRadius: 5)
                                .stroke(Color.gray, lineWidth: 0.3)
                        )
                    
                }
            }
        }
    }
}

extension ChoosenExerciseButtonView {
    private func deleteChoosenExercise(exercise: ChoosenExercise) {
        realmManager.deleteAllSets(choosenExerciseId: exercise.id)
        realmManager.deleteChoosenExercise(id: exercise.id)
    }
}

struct ChoosenExerciseButton_Previews: PreviewProvider {
    static var previews: some View {
        ChoosenExerciseButtonView(
            choosenExercise: Exercises.shared.getMocExercise().choosenExercises.first!)
        .environmentObject(RealmManager())
    }
}
