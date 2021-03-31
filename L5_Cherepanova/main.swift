//
//  main.swift
//  L5_Cherepanova
//
//  Created by Виктория Черепанова on 28.03.2021.
//

import Foundation

//1. Создать протокол «Car» и описать свойства, общие для автомобилей, а также методы действий.
//2. Создать расширения для протокола «Car» и реализовать в них методы конкретных действий с автомобилем: открыть/закрыть окно, запустить/заглушить двигатель и т.д. (по одному методу на действие, реализовывать следует только те действия, реализация которых общая для всех автомобилей).
//3. Создать два класса, имплементирующих протокол «Car» - trunkCar и sportСar. Описать в них свойства, отличающиеся для спортивного автомобиля и цистерны.
//4. Для каждого класса написать расширение, имплементирующее протокол CustomStringConvertible.
//5. Создать несколько объектов каждого класса. Применить к ним различные действия.
//6. Вывести сами объекты в консоль.

enum WindowsState: String {
    case open = "окна открыты"
    case closed = "окна закрыты"
}

enum DoorsState: String {
    case open = "двери открыты"
    case closed = "двери закрыты"
}

enum EngineState: String {
    case turnedOn = "двигатель заведен"
    case turnedOff = "двигатель заглушен"
}

//MARK: - Protocol
//у всех автомобилей общее - наличие бренда, года выпуска, трансмиссии, объёма багажника, также наличие изменяемых вариаций: пробег, состояние дверей, окон, двигателя
protocol Car: class {
    var brand: String {get set}
    var releaseYear: Int {get set}
    var kilometrage: Int {get set}
    var windowsState: WindowsState {get set}
    var doorsState: DoorsState {get set}
    var engineState: EngineState {get set}
}


//в расширения протокола выносим отдельными бусинками добавить пробег, открыть двери, открыть окна, завести / заглушить двигатель
extension Car {
    func addKilometrage (miles: Int) {
        if miles > 0 {
            kilometrage += miles
            print("Автомобиль проехал еще \(miles) км")
        } else if miles == 0 {
            print("Километраж автомобиля не изменился")
        }else{
         print("Недопустимое действие, показатели одометра нельзя изменять в меньшую сторону")
        }
    }
}

extension Car {
    func openWindows () {
        if windowsState == .open {
            print("Невозможно открыть окна, они уже открыты")
        } else {
            windowsState = .open
        }
    }
    
    func closeWindows () {
        if windowsState == .closed {
            print("Невозможно закрыть окна, они уже закрыты")
        } else {
            windowsState = .closed
        }
    }
}

extension Car {
    func openDoors () {
        if doorsState == .open {
            print("Невозможно открыть двери, они уже открыты")
        } else {
            doorsState = .open
        }
    }

    
    func closeDoors () {
        if doorsState == .closed {
            print("Невозможно закрыть двери, они уже закрыты")
        } else {
            doorsState = .closed
        }
    }
}

extension Car {
    func turnEngineOn () {
        if engineState == .turnedOn {
            print("Невозможно завести двигатель, он уже заведен")
        } else {
            engineState = .turnedOn
        }
    }
    
    func turnEngineOff () {
        if engineState == .turnedOff {
            print("Невозможно заглушить двигатель, он уже заглушен")
        } else {
            engineState = .turnedOff
        }
    }
}

//MARK: - TrunkCar

class TrunkCar: Car {
    var brand: String
    var releaseYear: Int
    var kilometrage: Int
    var windowsState: WindowsState
    var doorsState: DoorsState
    var engineState: EngineState
    var trunkState: Bool
    var trunkVolume: Double
    var trunkVolumeFilled: Double

    init (brand: String, releaseYear: Int, kilometrage: Int, windowsState: WindowsState, doorsState: DoorsState, engineState: EngineState, trunkState: Bool, trunkVolume: Double, trunkVolumeFilled: Double) {
        self.brand = brand
        self.kilometrage = kilometrage
        self.releaseYear = releaseYear
        self.windowsState = windowsState
        self.doorsState = doorsState
        self.engineState = engineState
        self.trunkState = trunkState
        self.trunkVolume = trunkVolume
        self.trunkVolumeFilled = trunkVolumeFilled
    }
    
    func unhookTrunk () {
        if trunkState == true {
        trunkState = false
        } else {
            print("Багажник уже отцеплен")
        }
    }
     
    func hookTrunk () {
        if trunkState == false {
        trunkState = true
        } else {
            print("Багажник уже прицеплен")
        }
    }
            
    func loadTrunk (cargo: Double) {
        if trunkState == false {
            print("Невозможно положить в автомобиль груз, пока багажник отцеплен")
        }else{
            if cargo <= trunkVolume - trunkVolumeFilled {
                trunkVolumeFilled += cargo
                print("В автомобиль загружено \(cargo) кг груза")
            }else{
                print("В автомобиль нельзя положить столько груза, уберите \(cargo - trunkVolume) кг")
            }
        }
    }
        
    func unloadTrunk (cargo: Double) {
            if cargo <= trunkVolumeFilled {
                trunkVolumeFilled = trunkVolumeFilled - cargo
                print("Из автомобиля выгружено \(cargo) кг груза")
            }else{
                print("Невозможно выгрузить из автомобиля \(cargo) кг. В автомобиле всего \(trunkVolumeFilled) кг  груза")
            }
        }
    
}

extension TrunkCar: CustomStringConvertible {
    var description: String {
        return "Автомобиль \(self.brand), \(self.releaseYear), пробег \(self.kilometrage), с багажником на \(self.trunkVolume) кг. Сейчас \(self.windowsState.rawValue), \(self.doorsState.rawValue), \(self.engineState.rawValue), багажник \(self.trunkState == true ? "прицеплен" : "отцеплен") и \(self.trunkVolumeFilled > 0 ? "загружен на \(self.trunkVolumeFilled) кг" : "не загружен")."
    }
}

//MARK: - SportCar

class SportCar: Car {
    var brand: String
    var releaseYear: Int
    var kilometrage: Int
    var windowsState: WindowsState
    var doorsState: DoorsState
    var engineState: EngineState
    var roofState: RoofState
    let gasKilometrage: Double

    init (brand: String, releaseYear: Int, kilometrage: Int, windowsState: WindowsState, doorsState: DoorsState, engineState: EngineState, roofState: RoofState, gasKilometrage: Double) {
        self.brand = brand
        self.kilometrage = kilometrage
        self.releaseYear = releaseYear
        self.windowsState = windowsState
        self.doorsState = doorsState
        self.engineState = engineState
        self.roofState = roofState
        self.gasKilometrage = gasKilometrage
    }
    
    enum RoofState: String {
        case raised = "крыша кабриолета поднята"
        case lowered = "крыша кабриолета опущена"
    }
    
    func roofChange (action: RoofState) {
        switch action {
        case .raised:
            if roofState == .raised {
                print("Крыша уже поднята,  ничего не изменится")
            } else {
                roofState = .raised
                print("Крыша кабриолета поднята")
            }

        case .lowered:
            if roofState == .lowered {
                print("Крыша уже опущена, это действие ничего не изменит")
            } else {
                roofState = .lowered
                print("Крыша кабриолета опущена")
            }
            
        }
    
    }
}

extension SportCar: CustomStringConvertible {
    var description: String {
        return "Автомобиль-кабриолет \(self.brand), \(self.releaseYear), пробег \(self.kilometrage) кг и расход топлива \(self.gasKilometrage) на 100 км. Сейчас \(self.windowsState.rawValue), \(self.doorsState.rawValue), \(self.engineState.rawValue), \(self.roofState.rawValue). "
    }
}

//MARK: - Create objects, make actions

var trunkСar1 = TrunkCar (brand: "Jeep", releaseYear: 2010, kilometrage: 100, windowsState: .open, doorsState: .open, engineState: .turnedOn, trunkState: true, trunkVolume: 2000.0, trunkVolumeFilled: 311.0)
var trunkCar2 = TrunkCar (brand: "Toyota", releaseYear: 2000, kilometrage: 0, windowsState: .closed, doorsState: .closed, engineState: .turnedOff, trunkState: false, trunkVolume: 2100.0, trunkVolumeFilled: 0.0)

var sportCar1 = SportCar (brand: "Subaru", releaseYear: 2005,  kilometrage: 100, windowsState: .closed, doorsState: .open, engineState: .turnedOn, roofState: .lowered, gasKilometrage: 10.0)
var sportCar2 = SportCar (brand: "Ferrary", releaseYear: 1990, kilometrage: 1000, windowsState: .closed, doorsState: .open, engineState: .turnedOff, roofState: .lowered, gasKilometrage: 12.0)

print("\(trunkСar1) \n", "\(trunkCar2) \n", "\(sportCar1) \n", sportCar2)
print("_________")
print("Сделаем что-нибудь с дверьми у первого грузовкика")
trunkСar1.closeDoors()
print(trunkСar1)
print("_________")

print("Проведем погрузку во второй грузовик")
print("____________")
trunkCar2.loadTrunk(cargo: 3455)
trunkCar2.hookTrunk()
trunkCar2.loadTrunk(cargo: 3455)
trunkCar2.loadTrunk(cargo: 2000)
print("_________")
print("Что получилось?")
print(trunkCar2)
print("_________")

print("Проведем выгрузку из первого грузовика")
trunkСar1.unloadTrunk(cargo: 350)
trunkСar1.unloadTrunk(cargo: 310)
print("_________")
print("Что получилось?")
print(trunkСar1)
print("_________")

print("Нужно проверить, как работает крыша у кабриолета")
sportCar1.roofChange(action: .lowered)
sportCar1.roofChange(action: .raised)

print("_________")
print("А на втором готовимся стартовать на прогулку")
sportCar2.roofChange(action: .raised)
sportCar2.turnEngineOn()
sportCar2.closeDoors()
sportCar2.openWindows()
print("_________")
print(sportCar2)
