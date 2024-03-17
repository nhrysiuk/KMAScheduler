//
//  FileReader.swift
//  KMAScheduler
//
//  Created by Анастасія Грисюк on 08.03.2024.
//

import Foundation

class FileReader {
    
    static let filePath = Bundle.main.path(forResource: "lessons", ofType: "json")
    
    static func fetchSubjectsFromFile() {
        do {
            if let filePath = filePath {
                let data = try Data(contentsOf: URL(fileURLWithPath: filePath))
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
}
