//
//  Exercises.swift
//  WorkoutDietDiary
//
//  Created by Анатолий Силиверстов on 19.09.2022.
//

import Foundation

class Exercises: ObservableObject {
    
    static let shared = Exercises()
            
    var chest = ["Жим Свенда", "Жим Свенда с Т-грифом", "Жим Свенда с гантелями лежа", "Жим в кроссовере горизонтально", "Жим в рычажном тренажере от груди вниз", "Жим в рычажном тренажере от груди вверх", "Жим в рычажном тренажере от груди вперед", "Жим гантелей лежа на полу", "Жим гантелей на горизонтальной скамье", "Жим гантелей на наклонной скамье (30 градусов) вверх", "Жим гантелей на наклонной скамье (45 градусов) вверх", "Жим гантелей на наклонной скамье с супинацией (разворотом)", "Жим гантелей на наклонной скамье вниз", "Жим гантелей на горизонтальной скамье одной рукой поочередно", "Жим лежа в кроссовере", "Жим штанги лежа на горизонтальной скамье","Жим штанги лежа на горизонтальной скамье в тренажере Смита", "Жим штанги лежа на наклонной скамье вниз", "Жим штанги лежа на наклонной скамье вверх", "Жим штанги лежа на наклонной скамье вверх в тренажере Смита", "Отжимания на брусьях в гравитроне", "Отжимания на брусьях", "Отжимания", "Пуловер с гантелью", "Разведение гантелей на горизонтальной скамье", "Разведение гантелей на наклонной скамье (30 градусов)", "Разведение гантелей на наклонной скамье (45 градусов)", "Разведение гантелей на наклонной скамье вниз", "Сведение рук в кроссовере лежа на горизонтальной скамье", "Сведение рук в кроссовере лежа на наклонной вверх скамье", "Сведение рук в кроссовере лежа на наклонной вниз скамье", "Сведение рук в кроссовере сверху стоя", "Сведение рук в кроссовере сверху стоя в наклоне", "Сведение рук в кроссовере снизу", "Сведение рук в тренажере Бабочка"]
    
    var shoulders = ["Жим штанги стоя за голову", "Жим штанги стоя Армейский жим","Жим штанги сидя за голову", "Жим штанги сидя перед собой", "Жим штанги сидя за голову в транежере Смита", "Жим штанги сидя перед собой в тренажере Смита", "Жим гантелей сидя", "Жим гантелей сидя с супинацией(разворотом) Жим Арнольда", "Жим вверх перед собой в тренажере","Жим гантелей лежа на груди на наклонной скамье", "Жим одной рукой Т - грифа стоя", "Махи в стороны в тренажере", "Махи в стороны в наклоне", "Махи гантелями в стороны сидя", "Махи гантелями в стороны стоя", "Махи гантелями перед собой", "Махи гантелями перед собой поочередно", "Отведение руки в сторону в наклоне в блоке", "Отведение руки в сторону стоя в блоке", "Отведение одной руки в сторону лежа боком на наклонной скамье", "Подьем рук перед собой в блоке стоя", "Подьем гантелей перед собой одновременно", "Подьем гантелей перед собой поочередно", "Подьем штанги перед собой", "Подьем блина перед собой", "Разведение рук в тренажере", "Разведение рук в кроссовере", "Тяга верхнего блока к лицу", "тяга гантелей к подбородку","Тяга изогнутой штанги к побородку", "Тяга к подбородку в кроссовере"]
    
    var back = ["Вертикальная тяга блока узким хватом к груди", "Вертикальная тяга блока за голову", "Вертикальная тяга в кроссовере с колен", "Вертикальная тяга обратным хватом к груди", "Вертикальная тяга широким хватом к груди", "Гиперэкстензия", "Горизонтальная рычажная тяга в тренажере", "Горизонтальная тяга блока сидя узким хватом", "Горизонтальная тяга блока сидя широким хватом", "Подтягивания в гравитроне", "Подтягивания в петлях TRX", "Подтягивания за голову", "Подтягивания к груди", "Пуловер на блоке стоя", "Пуловер со штангой на скамье", "Пуловер с гантелей на скамье", "Тяга Т - образного грифа", "Тяга в наклоне в тренажере Смита", "Тяга верхнего блока в тренажере Хаммера", "Тяга верхнего блока к шее", "Тяга гантелей к поясу на наклонной скамье", "Тяга гантели одной рукой на скамье", "Тяга рычажная сверху в тренажере", "Тяга рычажная спереди в тренажере", "Тяга штанги в наклоне к поясу", "Шраги"]
    
    var biceps = ["Подтягивания в гравитроне обратным хватом", "Подтягивания обратным хватом", "Поочередное сгибание рук сидя на наклонной скамье", "Поочереденое сгибание рук с разворотом сидя", "Поочередное сгибание рук стоя", "Поочередное сгибание рук с разворотом стоя", "Сгибание на скамье Скотта со штангой", "Сгибание на скамье Скотта в тренажере", "Сгибание одной руки на скамье Скотта", "Сгибание одной руки от колена", "Сгибание одной руки в блоке", "Сгибание рук в блоке", "Сгибание рук в блоке сидя на корточках", "Сгибание рук с гантелями хватом Молот", "Сгибание рук со штангой", "Сгибание рук со штангой лежа на наклонной скамье", "Сгибание рук со штангой узким хватом", "Сгибание рук в кроссовере"]
    
    var triceps = ["Жим лежа узким хватом", "Жим лежа узким хватом в тренажере Смита", "Обратные отжимания от скамьи", "Отжимания на брусьях","Отжимания на брусьях в гравитроне" ,"Отжимания от пола с узкой постановкой рук", "Разгибание одной руки в блоке", "Разгибание рук из - за головы со штангой стоя", "Разгибание рук из - за головы сидя", "Разгибание рук из - за головы лежа", "Разгибание одной руки из - за головы с гантелью", "Разгибание одной руки с гантелью в наклоне", "Разгибание одной руки к груди с гантелью лежа", "Разгибание рук в блоке", "Разгибание рук в тренажере", "Разгибание рук из - за головы в блоке", "Разгибание рук из - за головы с гантелью", "Разгибание рук с гантелями в наклоне", "Французский жим со штангой", "Французский жим с гантелями"]
    
    var legs = ["Болгарские приседания", "Боковые выпады", "Выпады вперед на месте", "Выпады в тренажере Смита", "Выпады в тренажере Смита с отведение ноги назад","Воздушные приседания", "Диагональные выпады", "Доброе утро", "Жим ногами", "Жим ногами горизонтальной платформы", "Жим одной ногой", "Жим одной ногой в блоке стоя", "Жим платформы носками", "Запрыгивания на тумбу", "Мертвая тяга", "Мертвая тяга в тренажере Смита","Наклоны на одной ноге", "Обратная гиперэкстензия","Обратные гакк - приседания", "Обратные гакк - приседания на одной ноге", "Отведение ноги в сторону в блоке", "Отведение ноги вверх в блоке с упором на скамью", "Отведение ноги назад в тренажере", "Подьем на носки в тренажере сидя", "Подьем на носки в тренажере стоя", "Подьем на носки на полу", "Приседания в Гакк - машине", "Приседания в тренажере Смита", "Приседания плие", "Приседания с гантелями", "Приседания со штангой", "Разгибание ног сидя в тренажере", "Разгибание одной ноги сидя в тренажере", "Разведение ног в тренажере сидя", "Сведение ног в тренажере сидя", "Сгибание ног лежа в тренажере", "Сгибание ног сидя в тренажере", "Сгибание ноги стоя в тренажере", "Сгибание ноги стоя в блоке", "Сизифовы приседания", "Становая тяга", "Становая тяга с гантелями", "Становая тяга сумо", "Ягодичный мост в тренажере Смита", "Ягодичный мост в тренажере", "Ягодичный мост на скамье"]
    
    var abs = ["Подьем ног в висе", "Складка в положении лежа", "Боковая планка на локте", "Диагональное скручивание", "Ножницы", "Скручивание на наклонной скамье", "Обратное скручивание на наклонной скамье", "Планка", "Подтягивание коленей к груди лежа на локтях", "Подьем туловища на полу с поднятыми ногами", "Скручивание в тренажере", "Скручивание  с гимнастическим роликом", "Упражнение Велосипед"]
    
    var cardio = ["Бег", "Беговая дорожка", "Вело - Эллипс", "Велотренажер", "Велотренажер горизонтальный", "Езда на велосипеде", "Лестница", "Тренажер Гребля", "Ходьба", "Эллиптический тренажер", "Степпер"]
    
    var forearms = ["Подьем груза на вращающейся балке", "Разгибание кисти в блоке", "Сгибание и разгибание кистей с гантелями хватом Молот стоя", "Сгибание кистей со штангой за спиной стоя", "Сгибание кистей в упоре на скамье"]
    
    func getMocExercise() -> Workout {
        let workout = Workout()
        let exercise = ChoosenExercise(icon: "chest", title: "Жим гантелей на наклонной скамье с супинацией (разворотом)", note: "...", date: Date())
        let sets = [Set(id: 1, repeats: "", weight: ""),
                    Set(id: 2, repeats: "", weight: ""),
                    Set(id: 3, repeats: "", weight: "")
        ]
        exercise.sets.append(objectsIn: sets)
        workout.choosenExercises.append(exercise)
        workout.exerciseGroups.append("Грудь")
        workout.exerciseGroups.append("Спина")
        workout.exerciseGroups.append("Плечи")

        return workout
    }
    
    func getMocDay() -> Day {
        let day = Day()
        let foods = [
            Food(name: "Chicken", calories: 300, date: Date()),
            Food(name: "Bacon", calories: 100, date: Date()),
            Food(name: "Fish", calories: 205, date: Date())
        ]
        
        var calories:Double = 0.0
        foods.forEach { food in
            calories += food.calories
        }
        day.foods.append(objectsIn: foods)
        day.calories = calories
        return day
    }
}
