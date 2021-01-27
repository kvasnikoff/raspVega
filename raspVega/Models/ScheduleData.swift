// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let scheduleData = try? newJSONDecoder().decode(ScheduleData.self, from: jsonData)

import Foundation

// MARK: - ScheduleData
struct ScheduleData: Codable {
    let settings: Settings
    let patterns: [Pattern]
    let const: Const
    let groups: [Group]
}

// MARK: - Const
struct Const: Codable {
    let colors: Colors
    let fullDay: FullDay
    let timePar: [String: String]
}

// MARK: - Colors
struct Colors: Codable {
    let кафедра, lang, ttt, colorsDefault: String

    enum CodingKeys: String, CodingKey {
        case кафедра, lang, ttt
        case colorsDefault = "default"
    }
}

// MARK: - FullDay
struct FullDay: Codable {
    let пн, вт, ср, чт: String
    let пт, сб: String

    enum CodingKeys: String, CodingKey {
        case пн = "ПН"
        case вт = "ВТ"
        case ср = "СР"
        case чт = "ЧТ"
        case пт = "ПТ"
        case сб = "СБ"
    }
}

// MARK: - Group
struct Group: Codable {
    let group: String
    let days: [DayElement]
    let type: String?
}

// MARK: - DayElement
struct DayElement: Codable {
    let day: DayEnum
    let pars: [Par]
}

enum DayEnum: String, Codable {
    case вт = "ВТ"
    case пн = "ПН"
    case пт = "ПТ"
    case сб = "СБ"
    case ср = "СР"
    case чт = "ЧТ"
}

// MARK: - Par
struct Par: Codable {
    let name: String
    let type: TypeEnum?
    let number: Int
    let place: String?
    let even, subgroup: Int?
    let whiteWeek: WhiteWeek?
    let whiteweek: Int?
    let length: String?
}

enum TypeEnum: String, Codable {
    case лабораторная = "лабораторная"
    case лекция = "лекция"
    case лекцияПрактика = "лекция / практика"
    case практика = "практика"
    case практикаЛаб = "практика / лаб."
}

enum WhiteWeek: Codable {
    case integer(Int)
    case string(String)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Int.self) {
            self = .integer(x)
            return
        }
        if let x = try? container.decode(String.self) {
            self = .string(x)
            return
        }
        throw DecodingError.typeMismatch(WhiteWeek.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for WhiteWeek"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .integer(let x):
            try container.encode(x)
        case .string(let x):
            try container.encode(x)
        }
    }
}

// MARK: - Pattern
struct Pattern: Codable {
    let pattern: String
    let search: Search
    let pr: String?
    let prLink: String?
    let comment, color, place: String?
}

enum Search: Codable {
    case string(String)
    case stringArray([String])

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode([String].self) {
            self = .stringArray(x)
            return
        }
        if let x = try? container.decode(String.self) {
            self = .string(x)
            return
        }
        throw DecodingError.typeMismatch(Search.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for Search"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .string(let x):
            try container.encode(x)
        case .stringArray(let x):
            try container.encode(x)
        }
    }
}

// MARK: - Settings
struct Settings: Codable {
    let firstWeekDate: String
    let maxPar: Int
}
