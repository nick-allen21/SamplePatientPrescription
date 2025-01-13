//
//  ContentView.swift
//  Assignment1
//
//  Created by Nick Allen on 1/12/25.
//

import SwiftUI

// Medication Struct
// Used to define a Medication Given to a Patient
struct Medication : Hashable{
    // Defining the necessary aspects of the medication struct
    let date : Date
    let name : String
    let dose : Double
    let route : String
    let frequency : Int
    let duration : Int
    let endDate : Date
    
    init(date: Date, name: String, dose: Double, route: String, frequency: Int, duration: Int, endDate: Date) {
        self.date = date
        self.name = name
        self.dose = dose
        self.route = route
        self.frequency = frequency
        self.duration = duration
        // safe unwrapping allowing for nil
        // Want to intialize end date to duration after the start date
        self.endDate = Calendar.current.date(byAdding: .day, value: duration, to: date) ?? date
    }
    
    var isCompleted : Bool {
        // if the current date is larger than
        // Computed Property
        Date() > endDate
    }
}

// Enumerable Blood Type Object
enum BloodType : String, CaseIterable {
    case APos = "A+"
    case ANeg = "A-"
    case BPos = "B+"
    case BNeg = "B-"
    case OPos = "O+"
    case ONeg = "O-"
    case ABPos = "AB+"
    case ABNeg = "AB-"
}

// Patient Struct
// Used to define a patient in our Array
struct Patient : Hashable{
    let MRN : String
    let name : String
    let surname : String
    let DOB : Date
    let height : Double
    let weight : Double
    let bloodType : BloodType
    var medications : [Medication]
    let age : Int
    
    // Patient Intialization
    init(MRN: String, name: String, surname: String, DOB: Date, height: Double, weight: Double, bloodType: BloodType, medications: [Medication], age: Int) {
        self.MRN = MRN
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
        }
    }
}

// Form that creates a new Patient in the array of existing patients
struct CreatePatientForm: View {
    @Binding var patients : [Patient]
    @State private var MRN: String = ""
    @State private var name: String = ""
    @State private var surname: String = ""
    @State private var DOB: Date = Date()
    @State private var height: String = ""
    @State private var weight: String = ""
    @State private var bloodType: BloodType = .APos
    @State private var age: String = ""
    
    // Function to actually add the patient to the array
    private func addPatient() {
        guard let heightValue = Double(height),
              let weightValue = Double(weight),
              let ageValue = Int(age) else { return }
        
        let newPatient = Patient(
            MRN: MRN,
            name: name,
            surname: surname,
            DOB: DOB,
            height: heightValue,
            weight: weightValue,
            bloodType: bloodType,
            medications: [],
            age: ageValue
        )
        patients.append(newPatient)
    }
    
    // We get the specifications for the patient here
    var body : some View {
        VStack{
            Form {
                    TextField("MRN", text: $MRN)
                    TextField("First Name", text: $name)
                    TextField("Last Name", text: $surname)
                    DatePicker("Date of Birth", selection: $DOB, displayedComponents: .date)
                    TextField("Height (cm)", text: $height)
                    TextField("Weight (kg)", text: $weight)
                    Picker("Blood Type", selection: $bloodType) {
                        ForEach(BloodType.allCases, id: \.self) { type in
                            Text(type.rawValue)
                        }
                    }
                    TextField("Age", text: $age)
                }
            
                Spacer()
                
                Button("Create Patient") {
                    addPatient()
                }
        }
            .navigationTitle("Create Patient")
        }
    }

// Form for creating a new Medication that we can ascribe to a patient
struct CreateMedicationForm: View {
    
    @Binding var medications : [Medication]
    @State private var date = Date()
    @State private var name: String = ""
    @State private var dose: String = ""
    @State private var route: String = ""
    @State private var frequency: String = ""
    @State private var duration: String = ""
    @State private var endDate: Date = Date()
   
    // function for actually adding that medication to the array of existing medications
    private func addMedication() {
        
        let newMedication = Medication(
            date : Date(),
            name: name,
            dose: Double(dose)!,
            route: route,
            frequency: Int(frequency)!,
            duration: Int(duration)!,
            endDate: endDate
        )
        medications.append(newMedication)
    }
    
    // Querying for information concerning a medication
    var body : some View {
        VStack{
            Form {
                TextField("Medication Name", text: $name)
                TextField("Dose (mg)", text: $dose)
                TextField("Route", text: $route)
                TextField("Frequency (per day)", text: $frequency)
                TextField("Duration (days)", text: $duration)
                }
                
                Spacer()
            
                Button("Create Medication") {
                    addMedication()
                }
                .navigationTitle("Create Patient")
            }
        }
        }


// The body of our program
// We bring the other two forms into view here
struct ContentView: View {
    // Init the patients & medications arrays and selected patients & meds
    @State var patients : [Patient] = []
    @State var selectedPatient : Patient?
    @State var medications : [Medication] = []
    @State var selectedMedication : Medication?
    @State var errorMessage : String?
    
    // Links to forms for these two sections
    var body: some View {
        NavigationStack{
            NavigationLink("Add New Patient") {
                CreatePatientForm(patients : $patients)
            }
            .padding()
            
            NavigationLink("Add New Medication") {
                CreateMedicationForm(medications : $medications)
            }
            .padding()
            
            Form {
                Section(header : Text("Choose a Patient")) {
                    Picker("Select Patient", selection: $selectedPatient) {
                        // want to uniquely indentiy by the MRN
                        ForEach(patients, id : \.MRN) { patient in
                            Text(patient.patientName())
                                //.tag line is what binds the selected patient
                                .tag(patient)
                        }
                    }
                }
            }
            .padding()
            
            Form {
                Section(header : Text("Choose a Medication")) {
                    Picker("Select Medication", selection: $selectedMedication) {
                        ForEach(medications, id : \.name) { medication in
                            Text(medication.name)
                                //.tag line is what binds the selected patient
                                .tag(medication)
                        }
                    }
                }
            }
            
            .padding()
            
            // Button for attributing the selected medication to the selectd patient
            Button("Prescribe Medication to Patient") {
                do {
                        if let medication = selectedMedication {
                            try selectedPatient?.prescribe(medication: medication)
                        } else {
                            errorMessage = "Please select a medication."
                        }
                    } catch Patient.prescriptionError.medicationExists {
                        errorMessage = "The selected medication already exists for this patient."
                    } catch {
                        errorMessage = "An unexpected error occurred. Please try again."
                    }
                }
            Text(errorMessage ?? "")
            .padding()
        }
    }
}

#Preview {
    ContentView()
}
