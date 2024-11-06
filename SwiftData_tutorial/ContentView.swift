//
//  ContentView.swift
//  SwiftData_tutorial
//
//  Created by 이승호 on 11/5/24.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) var context
    
    @Query var students: [Student]
    @Query var courses: [Course]

    @State var showingAddStudent = false
    @State var showingAddCourse = false
    @State var selectedStudent: Student?
    @State var selectedCourse: Course?
    
    func deleteStudents(offsets: IndexSet) {
        for index in offsets {
            context.delete(students[index])
        }
    }
    
    func deleteCourses(offsets: IndexSet) {
        for index in offsets {
            context.delete(courses[index])
        }
    }
    
    var body: some View {
        NavigationStack {
            List {
                Section(header: Text("Students")) {
                    ForEach(students) { student in
                        NavigationLink(destination: EditStudentView(student: student)) {
                            Text(student.name)
                        }
                    }
                    .onDelete(perform: deleteStudents)
                }
                
                Section(header: Text("Courses")) {
                    ForEach(courses) { course in
                        NavigationLink(destination: EditCourseView(course: course)) {
                            Text(course.name)
                        }
                    }
                    .onDelete(perform: deleteCourses)
                }
            }
            .navigationTitle("Students & Courses")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        showingAddStudent = true
                    }) {
                        Label("", systemImage: "person.crop.circle.badge.plus")
                    }
                }
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        showingAddCourse = true
                    }) {
                        Label("", systemImage: "book.closed.fill")
                    }
                }
            }
            .sheet(isPresented: $showingAddStudent, content: { AddStudentView() })
            .sheet(isPresented: $showingAddCourse, content: { AddCourseView() })
        }
    }
}
