//
//  ChoosenSetsView.swift
//  WorkoutDietDiary
//
//  Created by Анатолий Силиверстов on 19.09.2022.
//

import SwiftUI
import RealmSwift

struct ChoosenSetsView: View {
    @EnvironmentObject var realmManager: RealmManager
    @ObservedRealmObject var choosenExercise: ChoosenExercise
    @FocusState var isFocused: Bool?

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
            
            ForEach($choosenExercise.sets, id: \.id) { setNumber in
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
                .disabled(choosenExercise.sets.count >= 10)
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
                .disabled(choosenExercise.sets.count <= 1)
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
                    NavigationView {
                    PreviousExercisesView(previousExercises: $previousExercises, showingSheet: $showingSheet)
                        .navigationBarTitleDisplayMode(.inline)
                        .toolbar {
                            ToolbarItem(placement: .navigationBarTrailing) {
                                Button { showingSheet.toggle() } label: {
                                    Text("Готово")
                                }
                            }
                        }
                    }
                })
                Spacer()
            }
            .frame(width: width/1.1)
        }
    }
    
    private func addSet() {
        if choosenExercise.sets.count <= 9 {
            realmManager.addSet(
                id: choosenExercise.id)
        }
    }
    
    private func deleteSet() {
        realmManager.deleteLastSetFrom(choosenExerciseId: choosenExercise.id)
    }
    
    private func fetchPreviousExercises() {
        realmManager.getChoosenExercises()
        previousExercises = []
        let result = realmManager.choosenExercises.sorted(by: {$0.date.compare($1.date) == .orderedDescending})
        result.forEach { exercise in
            if exercise.title == choosenExercise.title && exercise.date != choosenExercise.date {
                previousExercises.append(exercise)
            }
        }
        showingSheet.toggle()
    }
}

struct ChoosenSetsView_Previews: PreviewProvider {
    static var previews: some View {
        ChoosenSetsView(
            choosenExercise: Exercises.shared.getMocExercise().choosenExercises.first!,
            buttonNotPressed: .constant(false),
            showingSheet: .constant(false),
            previousExercises: .constant([]))
                .environmentObject(RealmManager())
    }
}
