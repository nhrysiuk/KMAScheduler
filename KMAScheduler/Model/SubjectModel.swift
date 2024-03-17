//
//  SubjectModel.swift
//  KMAScheduler
//
//  Created by Анастасія Грисюк on 16.03.2024.
//

import Foundation

struct SubjectModel: Decodable {
    let name, faculty, specialty: String
    let year, trimester, numberOfGroups, id, group: Int64
    let type: String
    let isRegistered: Bool
}
