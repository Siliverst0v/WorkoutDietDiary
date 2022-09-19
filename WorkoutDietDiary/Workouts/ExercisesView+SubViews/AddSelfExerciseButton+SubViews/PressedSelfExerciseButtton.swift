//
//  PressedSelfExerciseButtton.swift
//  WorkoutDietDiary
//
//  Created by Анатолий Силиверстов on 19.09.2022.
//

import SwiftUI
import RealmSwift

struct PressedSelfExerciseButton: View {
    @EnvironmentObject var realmManager: RealmManager
    @FocusState var isFocused: Bool?
    @ObservedRealmObject var selfExercise: SelfExercise
    
    @State private var showingSheet = false
    @State private var previousExercises: [ChoosenExercise] = []
    
    @Binding var backgroundHeight: CGFloat
    @Binding var buttonNotPressed: Bool
    @Binding var isExerciseAdded: Bool
    @Binding var sets: [Set]
    @Binding var choosenExercises: [ChoosenExercise]
    @Binding var date: Date
    
    @Binding var image: String
    @Binding var note: String
    @State var showConfirm: Bool = false
    
    let buttonWidth = UIScreen.main.bounds.size.width - 40
    
    var body: some View {
        ZStack(alignment: .top) {
            ExerciseButtonsBackgroundView(
                width: buttonWidth,
                height: backgroundHeight + CGFloat(((sets.count - 1) * 46)))
            VStack(alignment: .center) {
                HStack {
                    Spacer()
                    Image(image)
                        .resizable()
                        .frame(width: 70, height: 40)
                    Spacer()
                    Text(selfExercise.title)
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
                    .buttonStyle(SimpleButtonStyle())
                    .confirmationDialog("", isPresented: $showConfirm, actions: {
                        Button("Удалить", role: .destructive) {
                            deleteSelfExercise()
                        }
                    })
                    Spacer()
                }
                .frame(width: buttonWidth, height: 70, alignment: .center)
                
                PressedSelfExerciseButtonSetsView(
                    isFocused: _isFocused,
                    selfExercise: selfExercise,
                    sets: $sets,
                    note: $note,
                    buttonNotPressed: $buttonNotPressed,
                    showingSheet: $showingSheet,
                    previousExercises: $previousExercises)
                
                TextEditor(text: $note)
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

extension PressedSelfExerciseButton {
    
    private func deleteSelfExercise() {
        realmManager.deleteSelfExercise(id: selfExercise.id)
    }
    
    private func addExercise() {
        isExerciseAdded.toggle()
        
        let choosenExercise = ChoosenExercise(icon: image, title: selfExercise.title, note: note, date: date)
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

struct PressedSelfExerciseButton_Previews: PreviewProvider {
    static var previews: some View {
        PressedSelfExerciseButton(
            selfExercise: SelfExercise(title: "Жим гантелей на наклонной скамье", exerciseGroup: "Грудь"),
            backgroundHeight: .constant(270),
            buttonNotPressed: .constant(true),
            isExerciseAdded: .constant(false),
            sets: .constant([Set(id: 1, repeats: "", weight: ""),
                             Set(id: 2, repeats: "", weight: ""),
                             Set(id: 3, repeats: "", weight: "")]),
            choosenExercises: .constant([]),
            date: .constant(Date()),
            image: .constant("chest"),
            note: .constant("...")
        )
        .environmentObject(RealmManager())
    }
}
