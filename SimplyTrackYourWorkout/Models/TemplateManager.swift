//
//  TemplateManager.swift
//  SimplyTrackYourWorkout
//
//  Created by Jan-Markus Langer on 21.01.25.
//
import SQLite

class TemplateManager {
    static let shared = TemplateManager()

    private let db: Connection?

    private let templates = Table("templates")
    private let templateID = Expression<Int64>("id")
    private let templateName = Expression<String>("name")

    private init() {
        db = DatabaseManager.shared.getConnection()
    }

    func createTemplate(name: String) -> Int64? {
        do {
            let insert = templates.insert(templateName <- name)
            let rowID = try db?.run(insert)
            return rowID
        } catch {
            print("Error creating template: \(error)")
            return nil
        }
    }
    
    func getTemplateName(by id: Int64?) -> String? {
        guard let id = id else { return nil }
        do {
            let query = templates.filter(templateID == id)
            if let template = try db?.pluck(query) {
                return template[templateName]
            }
        } catch {
            print("Error getting template name: \(error)")
        }
        return nil
    }


    func readTemplates() -> [(id: Int64, name: String)] {
        var result: [(id: Int64, name: String)] = []
        do {
            if let db = db {
                for template in try db.prepare(templates) {
                    let id = template[templateID]
                    let name = template[templateName]
                    result.append((id: id, name: name))
                }
            }
        } catch {
            print("Error reading templates: \(error)")
        }
        return result
    }

    func updateTemplate(id: Int64, newName: String) -> Bool {
        do {
            let template = templates.filter(templateID == id)
            let updatedRows = try db?.run(template.update(templateName <- newName)) ?? 0
            if updatedRows > 0 {
                print("Template \(id) updated successfully.")
                return true
            } else {
                print("Template \(id) not found or no changes made.")
            }
        } catch {
            print("Error updating template \(id): \(error)")
        }
        return false
    }
 

    func deleteTemplate(id: Int64) -> Bool {
        do {
            let template = templates.filter(templateID == id)
            if try db?.run(template.delete()) ?? 0 > 0 {
                return true
            }
        } catch {
            print("Error deleting template: \(error)")
        }
        return false
    }
    
    func deleteTemplateWithContent(id: Int64) -> Bool {
        do {
            let exercisesDeleted = TemplateExerciseManager.shared.deleteTemplateExercises(byTemplateID: id)
            if !exercisesDeleted {
                print("Error deleting template exercises for templateID \(id)")
                return false
            }

            // Lösche das Template
            let template = templates.filter(templateID == id)
            if try db?.run(template.delete()) ?? 0 > 0 {
                print("Template \(id) and its content deleted successfully.")
                return true
            }
        } catch {
            print("Error deleting template with content: \(error)")
        }
        return false
    }
}

