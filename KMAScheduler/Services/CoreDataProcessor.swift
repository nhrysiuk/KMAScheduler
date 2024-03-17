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
        try? context.save()
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
}

