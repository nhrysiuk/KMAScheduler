//
//  LessonModel.swift
//  KMAScheduler
//
//  Created by Анастасія Грисюк on 11.04.2024.
//

import Foundation

struct LessonModel: Decodable {
    let id, group: Int64
    let longitude, latitude: Double
    let auditorium, date, time, name: String
    let notes: String?
}
