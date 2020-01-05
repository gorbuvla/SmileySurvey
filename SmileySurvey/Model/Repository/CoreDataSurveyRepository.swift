//
//  CoreDataSurveyRepository.swift
//  SmileySurvey
//
//  Created by Vlad Gorbunov on 31/12/2019.
//  Copyright © 2019 Vlad Gorbunov. All rights reserved.
//

import Combine
import CoreData

final class CoreDataSurveyRepository {
    
    private let database: Database
    
    init(database: Database) {
        self.database = database
    }
    
    private var managedContext: NSManagedObjectContext {
        get { database.mainContext }
    }
    
    func save(survey: Survey) -> AnyPublisher<(), Error> {
        return Deferred {
            Future<(), Error> { promise in
                let entity = NSEntityDescription.entity(forEntityName: "DbSurvey", in: self.managedContext)
                
                do {
                    let managedObject = NSManagedObject(entity: entity!, insertInto: self.managedContext)
                    managedObject.set
                } catch {
                    
                }
            }
        }.eraseToAnyPublisher()
    }
    
    // TODO: errors
    func delete(survey: Survey) -> AnyPublisher<(), Error> {
        return Deferred {
            Future<(), Error> { promise in
                let request: NSFetchRequest<DbSurvey> = DbSurvey.fetchRequest()
                request.predicate = NSPredicate(format: "id = %@", argumentArray: [survey.id])
                
                do {
                    let matchedSurveys = try self.managedContext.fetch(request)
                    let surveyToDelete = matchedSurveys[0]
                    
                    self.managedContext.delete(surveyToDelete)
                    try self.managedContext.save()
                    promise(.success(()))
                } catch {
                    promise(.failure(error))
                }
                
            }
        }.eraseToAnyPublisher()
    }
}
