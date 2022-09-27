//
//  CustomButtonStyles.swift
//  WorkoutDietDiary
//
//  Created by Анатолий Силиверстов on 19.09.2022.
//

import SwiftUI

struct ExerciseButtonStyle: ButtonStyle {
    
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .font(.system(size: 14))
            .foregroundColor(.customBlue)
            .frame(width: UIScreen.main.bounds.size.width - 40,
                   height: 70,
                   alignment: .center)
            .background(
                Group {
                    if configuration.isPressed {
                        RoundedRectangle(cornerRadius: 11)
                            .fill(.white)
                            .overlay(
                                RoundedRectangle(cornerRadius: 11)
                                    .stroke(Color.gray, lineWidth: 3)
                                    .blur(radius: 10)
                                    .offset(x: 5, y: 5)
                                    .mask(
                                        RoundedRectangle(cornerRadius: 11)
                                        .fill(LinearGradient(Color.black, Color.gray)))
                            )
                            .overlay(
                                RoundedRectangle(cornerRadius: 11)
                                    .stroke(Color.white, lineWidth: 3)
                                    .blur(radius: 10)
                                    .offset(x: -5, y: -5)
                                    .mask(
                                        RoundedRectangle(cornerRadius: 11)
                                            .fill(LinearGradient(Color.black, Color.gray)))
                            )
                            .overlay(
                                RoundedRectangle(cornerRadius: 11)
                                    .stroke(Color.gray, lineWidth: 0.1)
                            )
                    } else {
                        RoundedRectangle(cornerRadius: 11)
                            .fill(.white)
                            .shadow(color: .black.opacity(0.2), radius: 10, x: 5, y: 5)
                            .shadow(color: .white.opacity(0.7), radius: 10, x: -5, y: -5)
                            .overlay(
                                RoundedRectangle(cornerRadius: 11)
                                    .stroke(Color.gray, lineWidth: 0.1)
                        )
                    }
                }
            )
    }
}

struct SimpleButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .background(
                Group {
                    if !configuration.isPressed {
                        RoundedRectangle(cornerRadius: 11)
                            .fill(.clear)
                            .overlay(
                                RoundedRectangle(cornerRadius: 11)
                                    .stroke(Color.gray, lineWidth: 0.3)
                            )
                    }
                }
            )
    }
}

struct ExerciseGroupButtonStyle: ButtonStyle {
    var isPressed: Bool
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .background(
                Group {
                    if isPressed {
                        RoundedRectangle(cornerRadius: 11)
                            .fill(.white)
                            .overlay(
                                RoundedRectangle(cornerRadius: 11)
                                    .stroke(Color.gray, lineWidth: 3)
                                    .blur(radius: 8)
                                    .offset(x: 5, y: 5)
                                    .mask(
                                        RoundedRectangle(cornerRadius: 11)
                                        .fill(LinearGradient(Color.black, Color.gray)))
                            )
                            .overlay(
                                RoundedRectangle(cornerRadius: 11)
                                    .stroke(Color.white, lineWidth: 3)
                                    .blur(radius: 8)
                                    .offset(x: -5, y: -5)
                                    .mask(
                                        RoundedRectangle(cornerRadius: 11)
                                            .fill(LinearGradient(Color.black, Color.gray)))
                            )
                            .overlay(
                                RoundedRectangle(cornerRadius: 11)
                                    .stroke(Color.gray, lineWidth: 0.1)
                            )
                    } else {
                        RoundedRectangle(cornerRadius: 11)
                            .fill(.white)
                            .shadow(color: .black.opacity(0.2), radius: 10, x: 5, y: 5)
                            .shadow(color: .white.opacity(0.7), radius: 10, x: -5, y: -5)
                            .overlay(
                                RoundedRectangle(cornerRadius: 11)
                                    .stroke(Color.gray, lineWidth: 0.1)
                        )
                    }
                }
            )
    }
}

struct WorkoutButtonStyle: ButtonStyle {
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(width: UIScreen.main.bounds.size.width - 40)
            .background (
                Group {
                    if configuration.isPressed {
                        RoundedRectangle(cornerRadius: 11)
                            .fill(.white)
                            .overlay(
                                RoundedRectangle(cornerRadius: 11)
                                    .stroke(Color.gray, lineWidth: 3)
                                    .blur(radius: 10)
                                    .offset(x: 5, y: 5)
                                    .mask(
                                        RoundedRectangle(cornerRadius: 11)
                                        .fill(LinearGradient(Color.black, Color.gray)))
                            )
                            .overlay(
                                RoundedRectangle(cornerRadius: 11)
                                    .stroke(Color.white, lineWidth: 3)
                                    .blur(radius: 10)
                                    .offset(x: -5, y: -5)
                                    .mask(
                                        RoundedRectangle(cornerRadius: 11)
                                            .fill(LinearGradient(Color.black, Color.gray)))
                            )
                            .overlay(
                                RoundedRectangle(cornerRadius: 11)
                                    .stroke(Color.gray, lineWidth: 0.1)
                            )
                    } else {
                        RoundedRectangle(cornerRadius: 11)
                            .fill(.white)
                            .shadow(color: .black.opacity(0.2), radius: 10, x: 5, y: 5)
                            .shadow(color: .white.opacity(0.7), radius: 10, x: -5, y: -5)
                            .overlay(
                                RoundedRectangle(cornerRadius: 11)
                                    .stroke(Color.gray, lineWidth: 0.1)
                        )
                    }
                }
            )
    }
}


struct DeleteButtonsStyle: ButtonStyle {
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(width: 40, height: 20, alignment: .center)
            .background (
                Group {
                    if configuration.isPressed {
                        RoundedRectangle(cornerRadius: 0)
                            .fill(.white)
                            .cornerRadius(11, corners: [.topLeft, .topRight])
                            .overlay(
                                RoundedRectangle(cornerRadius: 0)
                                    .stroke(Color.gray, lineWidth: 3)
                                    .blur(radius: 10)
                                    .offset(x: 5, y: 5)
                                    .cornerRadius(11, corners: [.topLeft, .topRight])
                                    .mask(
                                        RoundedRectangle(cornerRadius: 0)
                                        .fill(LinearGradient(Color.black, Color.gray))
                                        .cornerRadius(11, corners: [.topLeft, .topRight])
                                    )
                            )
                            .overlay(
                                RoundedRectangle(cornerRadius: 0)
                                    .stroke(Color.white, lineWidth: 3)
                                    .blur(radius: 10)
                                    .offset(x: -5, y: -5)
                                    .cornerRadius(11, corners: [.topLeft, .topRight])
                                    .mask(
                                        RoundedRectangle(cornerRadius: 0)
                                            .fill(LinearGradient(Color.black, Color.gray)))
                                            .cornerRadius(11, corners: [.topLeft, .topRight])
                            )
                            .overlay(
                                RoundedRectangle(cornerRadius: 0)
                                    .stroke(Color.gray, lineWidth: 0.1)
                                    .cornerRadius(11, corners: [.topLeft, .topRight])
                            )

                    } else {
                        RoundedRectangle(cornerRadius: 0)
                            .fill(.white)
                            .cornerRadius(11, corners: [.topLeft, .topRight])
                            .shadow(color: .black.opacity(0.2), radius: 10, x: 5, y: 5)
                            .shadow(color: .white.opacity(0.7), radius: 10, x: -5, y: -5)
                            .overlay(
                                RoundedRectangle(cornerRadius: 0)
                                    .stroke(Color.gray, lineWidth: 0.1)
                                    .cornerRadius(11, corners: [.topLeft, .topRight])
                        )
                    }
                }
            )
    }
}

extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape( RoundedCorner(radius: radius, corners: corners) )
    }
}

struct RoundedCorner: Shape {

    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}

extension LinearGradient {
    init(_ colors: Color...) {
        self.init(gradient: Gradient(colors: colors), startPoint: .topLeading, endPoint: .bottomTrailing)
    }
}

extension Color {
    static let customBlue = Color(red: 72/255, green: 110/255, blue: 158/255)
    static let customRed = Color(red: 216/255, green: 75/255, blue: 89/255)
}
