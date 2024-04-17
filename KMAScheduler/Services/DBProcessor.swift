//
//  DBProcessor.swift
//  KMAScheduler
//
//  Created by Анастасія Грисюк on 15.04.2024.
//

import Foundation

class DBProcessor {
    
    static let shared = DBProcessor()
    
    func fetchNormatives() -> [Subject] {
        guard let mySpecialty = CoreDataProcessor.shared.fetch(MySpecialty.self).first else { return [] }
        let allSubjects = CoreDataProcessor.shared.fetch(Subject.self)
        let normatives = allSubjects.filter { $0.type == "normative" && $0.specialty == mySpecialty.name && $0.year == mySpecialty.year }
        
        return normatives
    }
    
    func fetchProfessionals() -> [Subject] {
        guard let mySpecialty = CoreDataProcessor.shared.fetch(MySpecialty.self).first else { return [] }
        let allSubjects = CoreDataProcessor.shared.fetch(Subject.self)
        let selectives = allSubjects.filter { subject in
            return subject.isRegistered &&
                   subject.specialty == mySpecialty.name &&
                   subject.type == "prof"
        }
        
        return selectives
    }
    
    func fetchSelectives() -> [Subject] {
        guard let mySpecialty = CoreDataProcessor.shared.fetch(MySpecialty.self).first else { return [] }
        let allSubjects = CoreDataProcessor.shared.fetch(Subject.self)
        let selectives = allSubjects.filter {
            ($0.isRegistered && $0.specialty == mySpecialty.name &&
             $0.type == "selective") ||
            ($0.isRegistered && $0.specialty != mySpecialty.name)
        }
        
        return selectives
    }
    
    func fetchAllProfessionals() -> [Subject] {
        guard let mySpecialty = CoreDataProcessor.shared.fetch(MySpecialty.self).first else { return [] }
        let allSubjects = CoreDataProcessor.shared.fetch(Subject.self)
        let professionalSubjects = allSubjects.filter { $0.specialty == mySpecialty.name &&
            $0.type == "prof" && !$0.isRegistered }
        
        return professionalSubjects
    }
    
    func fetchAllSelectives() -> [Subject] {
        guard let mySpecialty = CoreDataProcessor.shared.fetch(MySpecialty.self).first else { return [] }
        let allSubjects = CoreDataProcessor.shared.fetch(Subject.self)
        let professionalSubjects = allSubjects.filter { (!$0.isRegistered && $0.specialty == mySpecialty.name && $0.type == "selective") ||
            (!$0.isRegistered && $0.specialty != mySpecialty.name) }
        
        return professionalSubjects
    }
    
    
    
}
