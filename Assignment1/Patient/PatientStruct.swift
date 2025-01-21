//
//  PatientStruct.swift
//  Assignment1
//
//  Created by Nick Allen on 1/20/25.
//

// Patient Struct
// Used to define a patient in our Array
import SwiftUI

struct Patient : Hashable{
    let MRN : UUID
    let name : String
    let surname : String
    let DOB : Date
    let height : Double
    let weight : Double
    let bloodType : BloodType?
    var medications : [Medication]
    let age : Int
    
    // Patient Intialization
    init(name: String, surname: String, DOB: Date, height: Double, weight: Double, bloodType: BloodType?, medications: [Medication]) {
        self.MRN = UUID()
        self.name = name
        self.surname = surname
        self.DOB = DOB
        self.height = height
        self.weight = weight
        self.bloodType = bloodType
        self.medications = medications
        let calendar = Calendar.current
        let currentDate = Date()
        let components = calendar.dateComponents([.year], from: DOB, to: currentDate)
        // Want to intialize age based off of the DOB and the current date
        self.age = components.year ?? 0
        
    }
    
    // Creates a patient name string
    func patientName() -> String {
        return name + " " + surname + ", \(age)"
    }
    
    // Creates a list of the medications for a patient
    func patientMedications() -> [String]{
        return medications
            .filter { !$0.isCompleted}
            .sorted { $0.date > $1.date}
            .map {$0.name}
    }
    
    // Enumerable error case
    // More cases to be added in future
    enum prescriptionError : Error {
        case medicationExists
    }
    
    // Function that alerts the medications array with new Medications
    // Gaurds against the case where we've already prescribed a medication with the same name
    // Need to address the re-allocation of same medicine case
    mutating func prescribe(medication : Medication) throws{
        guard !medications.contains(where: { $0.name == medication.name}) else {
            throw prescriptionError.medicationExists
        }
        medications.append(medication)
    }
    
    // Function that determines if a patient can recieve a certain blood type
    func receiveBlood(blood : BloodType) -> Bool {
        // blood is the blood of the donor
        
        switch bloodType {
            case .ABPos:
                return true
            case .ABNeg:
                return blood == .ONeg || blood == .BNeg || blood == .ANeg || blood == .ABPos
            case .APos:
                return blood == .ONeg ||  blood == .OPos || blood == .APos || blood == .ANeg
            case .ANeg:
                return blood == .ONeg || blood == .ANeg
            case .BPos:
                return blood == .ONeg || blood == .OPos || blood == .BPos || blood == .BNeg
            case .BNeg:
                return blood == .ONeg || blood == .BNeg
            case .OPos:
                return blood == .ONeg || blood == .OPos
            case .ONeg:
                return blood == .ONeg
            case nil:
                    return false
        }
    }
}

