//
//  AddSelfExerciseButton.swift
//  WorkoutDietDiary
//
//  Created by Анатолий Силиверстов on 19.09.2022.
//

import SwiftUI
import RealmSwift

struct AddSelfExerciseButton: View {
    @EnvironmentObject var realmManager: RealmManager
    @FocusState var isFocused: Bool?
    @State var buttonNotPressed: Bool = true
    @State var newExerciseTitle: String = ""
    @Binding var image: String
    @Binding var exerciseGroupName: String
    
    var body: some View {
        if buttonNotPressed {
            ZStack {
                Button( action: { buttonPressed() } ) {
                    HStack {
                        Spacer()
                        Image(image)
                            .resizable()
                            .frame(width: 70, height: 40)
                        Spacer()
                        Text("Добавить упражнение")
                            .fontWeight(.semibold)
                            .foregroundColor(.customRed)
                            .lineLimit(3)
                            .frame(width:
                                    width - 140,
                                   height: 70,
                                   alignment: .center)
                        Spacer()
                        Image(systemName: "plus.app")
                            .font(.system(size: 20))
                            .foregroundColor(.customRed)
                            .frame(width: 40,
                                   height: 40,
                                   alignment: .center)
                        Spacer()
                    }
                }
                .buttonStyle(ExerciseButtonStyle())
            }
        } else {
            ZStack(alignment: .top) {
                
                ExerciseButtonsBackgroundView(
                    width: width,
                    height: CGFloat(260))
                VStack(alignment: .center) {
                    HStack {
                        Spacer()
                        Image(image)
                            .resizable()
                            .frame(width: 70, height: 40)
                        Spacer()
                        Text("Добавить упражнение")
                            .fontWeight(.semibold)
                            .font(.system(size: 14))
                            .foregroundColor(.customRed)
                            .lineLimit(3)
                            .frame(width:
                                    width - 140,
                                   height: 70,
                                   alignment: .center)
                        Spacer()
                        Button(action: { addSelfExercise() }) {
                            Image(systemName: "plus.app")
                                .font(.system(size: 20))
                                .foregroundColor(.customRed)
                                .frame(width: 40,
                                       height: 40,
                                       alignment: .center)
                        }
                        .buttonStyle(SimpleButtonStyle())
                        Spacer()
                    }
                    .frame(width: width, height: 70)
                    
                    Text("Название:")
                        .font(.custom("semibold", size: 20))
                        .frame(width: width - 40, alignment: .leading)
                        .foregroundColor(.customBlue)
                    
                    TextEditor(text: $newExerciseTitle)
                        .frame(width: width - 40, height: 130)
                        .focused($isFocused, equals: true)
                        .foregroundColor(.customBlue)
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

extension AddSelfExerciseButton {
    func addSelfExercise() {
        buttonNotPressed.toggle()
        if !newExerciseTitle.isEmpty {
            realmManager.addSelfExercise(
                title: newExerciseTitle,
                exerciseGroup: exerciseGroupName)
            newExerciseTitle.removeAll()
        }
    }
    
    func buttonPressed() {
        buttonNotPressed.toggle()
        isFocused = true
    }
}

struct AddSelfExerciseButton_Previews: PreviewProvider {
    static var previews: some View {
        AddSelfExerciseButton(buttonNotPressed: true, image: .constant("chest"), exerciseGroupName: .constant("Грудь"))
    }
}
