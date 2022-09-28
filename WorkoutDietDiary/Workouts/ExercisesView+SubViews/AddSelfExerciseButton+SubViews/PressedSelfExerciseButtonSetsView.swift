//
//  PressedSelfExerciseButtonSetsView.swift
//  WorkoutDietDiary
//
//  Created by Анатолий Силиверстов on 19.09.2022.
//

import SwiftUI
import RealmSwift

struct PressedSelfExerciseButtonSetsView: View {
    @FocusState var isFocused: Bool?
    @EnvironmentObject var realmManager: RealmManager
    @ObservedRealmObject var selfExercise: SelfExercise
    
    @Binding var sets: [Set]
    @Binding var note: String
    @Binding var buttonNotPressed: Bool
    @Binding var showingSheet: Bool
    @Binding var previousExercises: [ChoosenExercise]
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Spacer()
                Text("Подходы")
                    .fontWeight(.semibold)
                    .foregroundColor(.customRed)
                Spacer()
                Text("Повторения")
                    .fontWeight(.semibold)
                    .foregroundColor(.customRed)
                Spacer()
                Text("Вес/Время")
                    .fontWeight(.semibold)
                    .foregroundColor(.customRed)
                Spacer()
            }
            .font(.system(size: 14))
            .frame(width: width/1.1)
            
            ForEach($sets, id: \.id) { setNumber in
                HStack() {
                    Spacer()
                    Text("\(setNumber.id)")
                        .fontWeight(.semibold)
                        .frame(width: 64)
                        .font(.system(size: 17))
                        .foregroundColor(.customBlue)
                    Spacer()
                    TextField("0", text: setNumber.repeats)
                        .focused($isFocused, equals: true)
                        .frame(width: 84)
                        .keyboardType(.decimalPad)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    Spacer()
                    TextField("0", text: setNumber.weight)
                        .focused($isFocused, equals: true)
                        .frame(width: 76)
                        .keyboardType(.decimalPad)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    Spacer()
                    
                }
                .frame(width: width/1.1)
            }
            
            HStack {
                Spacer()
                Button(action: { addSet() }) {
                    Text("+")
                        .font(.system(size: 25))
                        .fontWeight(.semibold)
                        .foregroundColor(.customBlue)
                        .frame(
                            width: 40,
                            height: 28,
                            alignment: .init(horizontal: .center, vertical: .bottom) )
                }
                .buttonStyle(SimpleButtonStyle())
                .disabled(sets.count >= 10)
                Button(action: { deleteSet() }) {
                    Text("-")
                        .font(.system(size: 25))
                        .fontWeight(.semibold)
                        .foregroundColor(.customRed)
                        .frame(
                            width: 40,
                            height: 28,
                            alignment: .init(horizontal: .center, vertical: .bottom) )
                }
                .buttonStyle(SimpleButtonStyle())
                .disabled(sets.count <= 1)
                Spacer()
                Button(action: { buttonNotPressed.toggle() }) {
                    Text("Сохранить")
                        .fontWeight(.semibold)
                        .frame(
                            width: 120,
                            height: 28,
                            alignment: .center )
                        .foregroundColor(.customRed)
                }
                .buttonStyle(SimpleButtonStyle())
                Spacer()
                Button(action: { self.fetchPreviousExercises() }) {
                    Image(systemName: "memories")
                        .frame(
                            width: 50,
                            height: 28,
                            alignment: .center )
                        .font(.system(size: 17))
                        .foregroundColor(.customBlue)
                }
                .buttonStyle(SimpleButtonStyle())
                .sheet(isPresented: $showingSheet, content: {
                    PreviousExercisesView(previousExercises: $previousExercises, showingSheet: $showingSheet)
                })
                Spacer()
            }
            .frame(width: width/1.1)

        }
    }
}

extension PressedSelfExerciseButtonSetsView {
    
    private func addSet() {
        let newSet = Set(
            id: sets.count + 1,
            repeats: "",
            weight: "")
        if sets.count <= 9 {
            sets.append(newSet)
        }
    }
    
    private func deleteSet() {
        sets.removeLast()
    }
    
    private func fetchPreviousExercises() {
        realmManager.getChoosenExercises()
        previousExercises = []
        let result = realmManager.choosenExercises.sorted(by: {$0.date.compare($1.date) == .orderedDescending})
        result.forEach { exercise in
            if exercise.title == selfExercise.title {
                previousExercises.append(exercise)
            }
        }
        showingSheet.toggle()
    }
}

struct PressedSelfExerciseButtonSetsView_Previews: PreviewProvider {
    static var previews: some View {
        PressedSelfExerciseButtonSetsView(
            selfExercise: SelfExercise(title: "Жим гантелей на наклонной скамье", exerciseGroup: "Грудь"),
            sets: .constant([Set(id: 1, repeats: "", weight: ""),
                                  Set(id: 2, repeats: "", weight: ""),
                                  Set(id: 3, repeats: "", weight: "")]),
            note: .constant("..."),
            buttonNotPressed: .constant(false),
            showingSheet: .constant(false),
            previousExercises: .constant([]))
        .environmentObject(RealmManager())
    }
}
