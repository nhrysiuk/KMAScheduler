//
//  FileReader.swift
//  KMAScheduler
//
//  Created by Анастасія Грисюк on 08.03.2024.
//

import Foundation

class FileReader {
    
    static let subjectsFilePath = Bundle.main.path(forResource: "subjects", ofType: "json")
    static let lessonsFilePath = Bundle.main.path(forResource: "schedule", ofType: "json")
    
    static func fetchSubjectsFromFile() {
        do {
            if let subjectsFilePath = subjectsFilePath {
                let data = try Data(contentsOf: URL(fileURLWithPath: subjectsFilePath))
                let decoder = JSONDecoder()
                let subjects = try decoder.decode([SubjectModel].self, from: data)
                
                saveToCoreData(subjects)
            }
        } catch {
            print("Помилка при читанні або парсингу JSON-файлу:", error.localizedDescription)
        }
    }
    
    static func saveToCoreData(_ subjects: [SubjectModel]) {
        subjects.forEach { convertToCD($0) }
        CoreDataProcessor.shared.saveContext()
    }
    
    static func convertToCD(_ model: SubjectModel) {
        let subject = Subject(context: CoreDataProcessor.shared.context)
        subject.id = model.id
        subject.name = model.name
        subject.faculty = model.faculty
        subject.specialty = model.specialty
        subject.year = model.year
        subject.trimester = model.trimester
        subject.numberOfGroups = model.numberOfGroups
        subject.type = model.type
        subject.isRegistered = model.isRegistered
        subject.group = model.group
    }
    
    static func fetchLessonsFromFile() {
        do {
            if let lessonsFilePath = lessonsFilePath {
                let data = try Data(contentsOf: URL(fileURLWithPath: lessonsFilePath))
                let decoder = JSONDecoder()
                let lessons = try decoder.decode([LessonModel].self, from: data)
                print(lessons)
                saveLessonsToCoreData(lessons)
            }
        } catch {
            print("Помилка при читанні або парсингу JSON-файлу з розкладом:", error.localizedDescription)
        }
    }
    
    static func saveLessonsToCoreData(_ lessons: [LessonModel]) {
        lessons.forEach { convertLessonsToCD($0) }
        CoreDataProcessor.shared.saveContext()
    }
    
    static func convertLessonsToCD(_ model: LessonModel) {
        let lesson = Lesson(context: CoreDataProcessor.shared.context)
        lesson.id = model.id
        lesson.auditorium = model.auditorium
        lesson.lessonDate = model.date
        lesson.lessonTime = model.time
        lesson.group = model.group
        lesson.name = model.name
    }
}
