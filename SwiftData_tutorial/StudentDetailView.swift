//
//  StudentDetailView.swift
//  SwiftData_tutorial
//
//  Created by 이승호 on 11/5/24.
//

import SwiftUI
import SwiftData

// 해당 학생의 수강 정보를 보여주는 뷰
struct StudentDetailView: View {
    @Binding var student: Student // 특정 학생에 대한 정보니까 Binding
    @Query var courses: [Course]
    @State var selectedCourse: Course?
    
    // 수강 목록 뷰
    var enrolledCourseView: some View {
        ForEach(student.courses) { course in
            Text(course.name)
        }
        .onDelete(perform: removeFromCourse)
    }

    // 수강 신청 뷰
    var addCourseView: some View {
        Picker("Add Course", selection: $selectedCourse) {
            Text("Select A Course").tag(nil as Course?)
            
            // 수강 신청 가능한 목록에 대해서만
            ForEach(availableCourses, id: \.self) { course in
                Text(course.name).tag(course as Course?)
                
            }
        }
        .onChange(of: selectedCourse) { _, newValue in
            if let course = newValue {
                addCourseToStudent(course)
                selectedCourse = nil
            }
        }
    }
    
    // 수강 목록 삭제
    func removeFromCourse(offset: IndexSet) {
        for index in offset {
            let course = student.courses[index]
            student.courses.remove(at: index)
            course.students.removeAll {
                $0.id == student.id
            }
        }
    }
    
    // 수강 신청
    func addCourseToStudent(_ course: Course) {
        student.courses.append(course)
        course.students.append(student)
    }
    
    // 수강 신청 가능 목록
    var availableCourses: [Course] {
        courses.filter {
            !student.courses.contains($0)
        }
    }
    
    var body: some View {
        List {
            Section(header: Text("Name")) {
                TextField("Course Name", text: $student.name)
            }
            Section(header: Text("Enrolled Courses")) {
                enrolledCourseView
                addCourseView
            }
        }
        .navigationTitle(student.name)
    }
}

// 수강한 과목에 대한 정보를 보여주는 뷰
struct CourseDetailView: View {
    @Binding var course: Course
    @Query var students: [Student]
    @State var selectedStudent: Student?
    
    // 이 과목을 수강한 학생들을 보여주는 뷰
    var enrolledStudentsView: some View {
        ForEach(course.students) { student in
            Text(student.name)
        }
        .onDelete(perform: removeFromStudent)
    }
    
    // 학생을 이 과목에 등록하는 뷰
    var addStudentView: some View {
        Picker("Add Student", selection: $selectedStudent) {
            Text("Select A Student").tag(nil as Student?)
            
            // 수강 신청 가능한 목록에 대해서만
            ForEach(availableStudents, id: \.self) { student in
                Text(student.name).tag(student as Student?)
                
            }
        }
        .onChange(of: selectedStudent) { _, newValue in
            if let student = newValue {
                addStudentToCourse(student)
                selectedStudent = nil
            }
        }
    }
    
    // 이 과목에서 학생을 삭제
    func removeFromStudent(offset: IndexSet) {
        for index in offset {
            let student = course.students[index]
            course.students.remove(at: index)
            student.courses.removeAll {
                $0.id == student.id
            }
        }
    }
    
    // 과목에 학생을 등록
    func addStudentToCourse(_ student: Student) {
        course.students.append(student)
        student.courses.append(course)
    }
    
    // 등록이 가능한 학생들
    var availableStudents: [Student] {
        students.filter {
            !course.students.contains($0)
        }
    }
    
    var body: some View {
        List {
            Section(header: Text("Name")) {
                TextField("Student Name", text: $course.name)
            }
            Section(header: Text("Enrolled Courses")) {
                enrolledStudentsView
                addStudentView
            }
        }
        .navigationTitle(course.name)
    }
}

