//
//  PressedButtonView.swift
//  WorkoutDietDiary
//
//  Created by Анатолий Силиверстов on 19.09.2022.
//

import SwiftUI
import RealmSwift

struct PressedButtonView: View {
    @EnvironmentObject var realmManager: RealmManager
    @FocusState var isFocused: Bool?

    @State private var showingSheet = false
    @State private var previousExercises: [ChoosenExercise] = []
    
    @Binding var backgroundHeight: CGFloat
    @Binding var buttonNotPressed: Bool
    @Binding var isExerciseAdded: Bool
    @Binding var sets: [Set]
    @Binding var choosenExercises: [ChoosenExercise]
    @Binding var date: Date
    
    @Binding var image: String
    @Binding var title: String
    @Binding var note: String
    
    var body: some View {
        ZStack(alignment: .top) {
            ExerciseButtonsBackgroundView(
                width: width,
                height: backgroundHeight + CGFloat(((sets.count - 1) * 46)))
            VStack(alignment: .center) {
                HStack {
                    Spacer()
                    Image(image)
                        .resizable()
                        .frame(width: 70, height: 40)
                    Spacer()
                    Text(title)
                        .fontWeight(.semibold)
                        .font(.system(size: 14))
                        .foregroundColor(.customBlue)
                        .lineLimit(3)
                        .frame(
                            width: width - 140,
                            height: 60,
                            alignment: .leading)
                    Spacer()
                    Button(action: {}) {
                        Image(systemName: "trash")
                            .font(.system(size: 20))
                            .foregroundColor(.customRed)
                            .frame(width: 40,
                                   height: 40,
                                   alignment: .center)
                    }
                    .buttonStyle(SimpleButtonStyle())
                    .opacity(0)
                    .disabled(true)
                    Spacer()
                }
                .frame(width: width, height: 70, alignment: .center)
                
                SetsView(isFocused: _isFocused,
                         sets: $sets,
                         note: $note,
                         buttonNotPressed: $buttonNotPressed,
                         showingSheet: $showingSheet,
                         previousExercises: $previousExercises,
                         title: $title)
                
                TextEditor(text: $note)
                    .focused($isFocused, equals: true)
                    .foregroundColor(.customBlue)
                    .lineLimit(2)
                    .frame(width: width - 40, height: 80)
                    .cornerRadius(10)
                    .overlay(
                        RoundedRectangle(cornerRadius: 5)
                            .stroke(Color.gray, lineWidth: 0.3)
                    )
                
            }
        }
    }
}


extension PressedButtonView {
    
    private func fetchPreviousExercises() {
        realmManager.getChoosenExercises()
        previousExercises = []
        let result = realmManager.choosenExercises.sorted(by: {$0.date.compare($1.date) == .orderedDescending})
        result.forEach { exercise in
                if exercise.title == title {
                    previousExercises.append(exercise)
            }
        }
        showingSheet.toggle()
    }
    
    private func addExercise() {
        isExerciseAdded.toggle()
        
        let choosenExercise = ChoosenExercise(icon: image, title: title, note: note, date: date)
        sets.forEach { setToAppend in
            choosenExercise.sets.append(Set(id: setToAppend.id, repeats: setToAppend.repeats, weight: setToAppend.weight))
        }
        
        if isExerciseAdded {
            choosenExercises.append(choosenExercise)
        } else {
            choosenExercises.removeAll(where: {$0.title == choosenExercise.title})
        }
    }
}

struct PressedButtonView_Previews: PreviewProvider {
    static var previews: some View {
        PressedButtonView(
            backgroundHeight: .constant(270),
            buttonNotPressed: .constant(true),
            isExerciseAdded: .constant(false),
            sets: .constant([Set(id: 1, repeats: "", weight: ""),
                             Set(id: 2, repeats: "", weight: ""),
                             Set(id: 3, repeats: "", weight: "")]),
            choosenExercises: .constant([]),
            date: .constant(Date()),
            image: .constant("chest"),
            title: .constant("Exercise for example"),
            note: .constant("...")
        )
        .environmentObject(RealmManager())
    }
}
