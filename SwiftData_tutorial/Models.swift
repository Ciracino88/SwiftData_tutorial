//
//  Models.swift
//  SwiftData_tutorial
//
//  Created by 이승호 on 11/5/24.
//

import SwiftData

@Model
class Course {
    var name: String
    var students: [Student] = []
    @Relationship(inverse: \Student.courses)
    
    init(name: String) {
        self.name = name
    }
}

@Model
class Student {
    var name: String
    var courses: [Course] = []
    
    init(name: String) {
        self.name = name
    }
}
