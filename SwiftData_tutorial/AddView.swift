//
//  AddView.swift
//  SwiftData_tutorial
//
//  Created by 이승호 on 11/5/24.
//

import SwiftUI

struct AddCourseView: View {
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss
    
    @State var name: String = ""
    
    var body: some View {
        NavigationStack {
            Form {
                TextField("Course Name", text: $name)
            }
            .navigationTitle("Add Course")
            .navigationBarItems(leading: Button("Cancel") {
                dismiss()
            }, trailing: Button("Save") {
                let newCourse = Course(name: name)
                modelContext.insert(newCourse)
                dismiss()
            })
        }
    }
}

struct AddStudentView: View {
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss
    
    @State var name: String = ""
    
    var body: some View {
        NavigationStack {
            Form {
                TextField("Student Name", text: $name)
            }
            .navigationTitle("Add Student")
            .navigationBarItems(leading: Button("Cancel") {
                dismiss()
            }, trailing: Button("Save") {
                let newStudent = Student(name: name)
                modelContext.insert(newStudent)
                dismiss()
            })
        }
    }
}
