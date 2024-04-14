//
//  CoreDataProcessor.swift
//  KMAScheduler
//
//  Created by Анастасія Грисюк on 08.03.2024.
//

import Foundation
import CoreData
import UIKit

class CoreDataProcessor {
    
    static let shared = CoreDataProcessor.init()
    
    var context: NSManagedObjectContext { (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext }
    
    func fetch<T: NSManagedObject>(_ type: T.Type) -> [T] {
        let request = NSFetchRequest<T>(entityName: String(describing: T.self))
        
        let data = (try? context.fetch(request)) ?? []
        
        return data
    }
    
    func saveContext() {
        do {
            try context.save()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func fetchSpecialties() -> [MySpecialty] {
        let request = MySpecialty.fetchRequest()
 
        var fetchedSpecialties = [MySpecialty]()
        do {
            fetchedSpecialties = try CoreDataProcessor.shared.context.fetch(request)
        } catch {
            print("Error fetching transactions: \(error.localizedDescription)")
        }
        
        return fetchedSpecialties
    }
    
    func deleteExistingSpecialties() {
        let fetchRequest: NSFetchRequest<MySpecialty> = MySpecialty.fetchRequest()
        let context = CoreDataProcessor.shared.context
        
        do {
            let specialties = try context.fetch(fetchRequest)
            for specialty in specialties {
                context.delete(specialty)
            }
            try context.save()
        } catch {
            print("Помилка під час видалення спеціальностей: \(error.localizedDescription)")
        }
    }
    
    func fetchLessons(for date: Date) -> [Lesson] {
        let fetchedLessons = CoreDataProcessor.shared.fetch(Lesson.self)
        
        guard !fetchedLessons.isEmpty else { return [] }

        let subjects = CoreDataProcessor.shared.fetch(Subject.self)
        let filteredSubjects = subjects.filter { $0.isRegistered }
        let ids = filteredSubjects.map { $0.id }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        
        let calendar = Calendar.current
        let date1 = calendar.dateComponents([.day, .month, .year], from: date)
        
        let filteredLessons = fetchedLessons.filter { lesson in
            print(lesson)
            guard let dateString = dateFormatter.date(from: lesson.lessonDate!) else { return false }
            let date2 = calendar.dateComponents([.day, .month, .year], from: dateString)
            
            let subject = filteredSubjects.first { $0.id == lesson.id }
            let group = subject?.group

            if ids.contains(lesson.id) && date2 == date1 && lesson.group == group {
                print(lesson.id)
                return true
            } else {
                return false
            }
        }
        
        return filteredLessons
    }
}

