//
//  NotPressedButtonView.swift
//  WorkoutDietDiary
//
//  Created by Анатолий Силиверстов on 19.09.2022.
//

import SwiftUI

struct NotPressedButtonView: View {
    
    @Binding var buttonNotPressed: Bool
    @Binding var exerciseAdded: Bool
    @Binding var sets: [Set]
    @Binding var choosenExercises: [ChoosenExercise]
    @Binding var date: Date
    
    @Binding var image: String
    @Binding var title: String
    @Binding var note: String
    
    let buttonWidth = UIScreen.main.bounds.size.width - 40

    var body: some View {
        ZStack{
            Button( action: { buttonNotPressed.toggle() } ) {
                HStack {
                    Spacer()
                    Image(image)
                        .resizable()
                        .frame(width: 70, height: 40)
                    Spacer()
                    Text(title)
                        .fontWeight(.semibold)
                        .lineLimit(3)
                        .frame(
                            width: buttonWidth - 140,
                            height: 70,
                            alignment: .leading)
                    Spacer()
                    Button(action: { addExercise() }) {
                        Image(systemName: exerciseAdded ? "checkmark.square" : "square")
                            .font(.system(size: 20))
                            .foregroundColor(.customBlue)
                            .frame(width: 40,
                                   height: 40,
                                   alignment: .center)
                    }
                    Spacer()
                }
                .frame(width: buttonWidth, height: 70, alignment: .center)
            }
            .buttonStyle(ExerciseButtonStyle())
        }
    }
}

extension NotPressedButtonView {
    func addExercise() {
        exerciseAdded.toggle()
        
        let choosenExercise = ChoosenExercise(
            icon: image,
            title: title,
            note: note,
            date: date)
        
        sets.forEach { sett in
            choosenExercise.sets.append(
                Set(
                    id: sett.id,
                    repeats: sett.repeats,
                    weight: sett.weight))
        }
        
        if exerciseAdded {
            choosenExercises.append(choosenExercise)
        } else {
            choosenExercises.removeAll(where: {$0.title == choosenExercise.title})
        }
    }
}

struct NotPressedButtonView_Previews: PreviewProvider {
    static var previews: some View {
        NotPressedButtonView(
            buttonNotPressed: .constant(true),
            exerciseAdded: .constant(true),
            sets: .constant([
                Set(id: 1, repeats: "", weight: ""),
                Set(id: 2, repeats: "", weight: ""),
                Set(id: 3, repeats: "", weight: "")]),
            choosenExercises: .constant([]),
            date: .constant(Date()),
            image: .constant("chest"),
            title: .constant("Жим лежа на скамье"),
            note: .constant("...")
        )
    }
}
