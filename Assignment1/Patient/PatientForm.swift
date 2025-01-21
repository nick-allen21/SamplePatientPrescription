//
//  Untitled.swift
//  Assignment1
//
//  Created by Nick Allen on 1/20/25.
//

import SwiftUI

// Form that creates a new Patient in the array of existing patients
struct CreatePatientForm: View {
    // This is the child view that is bound to the
    // parent view in the contentview item
    // allows the UI to automatically be updated
    @Binding var patients : [Patient]
    @State private var name: String = ""
    @State private var surname: String = ""
    @State private var DOB: Date = Date()
    @State private var height: String = ""
    @State private var weight: String = ""
    @State private var bloodType: BloodType? = nil
    
    // Access the dismiss environment
    @Environment(\.dismiss) private var dismiss
    
    // Function to actually add the patient to the array
    private func addPatient() {
        
        let newPatient = Patient(
            name: name,
            surname: surname,
            DOB: DOB,
            height: Double(height) ?? 0,
            weight: Double(weight) ?? 0,
            bloodType: bloodType,
            medications: []
        )
        patients.append(newPatient)
        patients.sort { $0.surname < $1.surname }
        dismiss()
    }
    
    // Function to determine if the form is completed or not
    private var isFormComplete: Bool {
            !name.isEmpty &&
            !surname.isEmpty &&
            !(Double(height) ?? 0).isZero &&
            !(Double(weight) ?? 0).isZero
        }
    
    // We get the specifications for the patient here
    var body : some View {
        VStack{
            Form {
                TextField("First Name", text: $name)
                TextField("Last Name", text: $surname)
                DatePicker("Date of Birth", selection: $DOB, displayedComponents: .date)
                TextField("Height (in)", text: $height)
                TextField("Weight (lbs)", text: $weight)
                Picker("Blood Type", selection: $bloodType) {
                    ForEach(BloodType.allCases, id: \.self) { type in
                        Text(type.rawValue).tag(Optional(type))
                    }
                }
            }
            
                Spacer()
                
                Button("Create Patient") {
                    addPatient()
                }
                // Disable button until form is complete
                .disabled(!isFormComplete)
        }
            .navigationTitle("Create Patient")
        }
    }
