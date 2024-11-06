//
//  EditStudentView.swift
//  SwiftData_tutorial
//
//  Created by 이승호 on 11/5/24.
//

import SwiftUI
import SwiftData

struct EditStudentView: View {
    @Bindable var student: Student // 바인딩 값일수도 있고, 아닐수도 있고
    @Environment(\.modelContext) var context
    @Environment(\.dismiss) var dismiss
    @Query var courses: [Course]
    
    @State var selectedCourse: Set<Course> = []
    
    var body: some View {
        Form {
            TextField("Name", text: $student.name)
            
            Section(header: Text("Enrolled Courses")) {
                ForEach(courses) { course in
                    Toggle(course.name, isOn: Binding(get: {
                        selectedCourse.contains(course)
                    }, set: {
                        isSelected in
                        
                        if isSelected {
                            selectedCourse.insert(course)
                            student.courses.append(course)
                        } else {
                            selectedCourse.remove(course)
                            student.courses.removeAll {
                                $0.id == course.id
                            }
                        }
                    }))
                }
            }
        }
        .navigationTitle("Edit Student")
        .navigationBarItems(trailing: Button("Save") {
            do {
                try context.save()
                dismiss()
            } catch {
                print("Error Saving: \(error.localizedDescription)")
            }
        })
        .onAppear {
            selectedCourse = Set(student.courses)
        }
    }
}

struct EditCourseView: View {
    @Bindable var course: Course
    @Environment(\.modelContext) var context
    @Environment(\.dismiss) var dismiss
    @Query var students: [Student]
    
    @State var selectedStudents: Set<Student> = []
    
    var body: some View {
        Form {
            TextField("Name", text: $course.name)
            Section(header: Text("Enrolled Students")) {
                ForEach(students) { student in
                    
                    Toggle(student.name, isOn: Binding(get: {
                        selectedStudents.contains(student)
                    }, set: {
                        isSelected in
                        
                        if isSelected {
                            selectedStudents.insert(student)
                            course.students.append(student)
                        } else {
                            selectedStudents.remove(student)
                            course.students.removeAll {
                                $0.id == student.id
                            }
                        }
                    }))
                }
            }
        }
        .navigationTitle("Edit Student")
        .navigationBarItems(trailing: Button("Save") {
            do {
                try context.save()
                dismiss()
            } catch {
                print("Error Saving: \(error.localizedDescription)")
            }
        })
        .onAppear {
            selectedStudents = Set(course.students)
        }
    }
}
