//
//  CoreDataSurveyRepository.swift
//  SmileySurvey
//
//  Created by Vlad Gorbunov on 31/12/2019.
//  Copyright © 2019 Vlad Gorbunov. All rights reserved.
//

import Combine
import CoreData

final class CoreDataSurveyRepository: SurveyRepositoring {
    
    private let database: Database
    private let collector: CollectionDataObserver

    init(database: Database) {
        self.database = database
        self.collector = CollectionDataObserver(database: database)
    }
    
    private var managedContext: NSManagedObjectContext {
        get { Database.shared.mainContext }
    }
    
    func create(survey: Survey) -> AnyPublisher<(), Error> {
        return Deferred {
            Future<(), Error> { promise in
                let entity = NSEntityDescription.entity(forEntityName: "DbSurvey", in: self.managedContext)
            
                let item = NSManagedObject(entity: entity!, insertInto: self.managedContext)
                item.setValue(survey.id, forKey: "id")
                item.setValue(survey.name, forKey: "name")
                item.setValue(survey.question, forKey: "question")
                item.setValue(survey.excellent, forKey: "excellent")
                item.setValue(survey.good, forKey: "good")
                item.setValue(survey.bad, forKey: "bad")
                item.setValue(survey.disaster, forKey: "disaster")
                
                
                do {
                    try self.managedContext.save()
                    promise(.success(()))
                } catch {
                    print("DB save error: \(error)")
                    promise(.failure(error))
                }
            }
        }.eraseToAnyPublisher()
    }
    
    func observe(filter: FilterOption) -> AnyPublisher<[Survey], Never> {
        return collector.subject
            .map {
                $0.compactMap { dbSurvey in dbSurvey.toDomain() }
                    .filter { survey in
                        if case .single(let id) = filter {
                            return survey.id == id
                        } else {
                            return true
                        }
                    }
            }.eraseToAnyPublisher()
    }
    
    func observe() -> AnyPublisher<[Survey], Never> {
        return collector.subject
            .map { $0.compactMap { dbSurvey in dbSurvey.toDomain() }}
            //.mapError { $0 as Error }
            .eraseToAnyPublisher()
    }
    
    func update(_ survey: Survey, rating: Rating) -> AnyPublisher<(), Error> {
        return Deferred {
            Future<(), Error> { promise in
                let request: NSFetchRequest<DbSurvey> = DbSurvey.fetchRequest()
                request.predicate = NSPredicate(format: "id = %@", argumentArray: [survey.id])
                
                do {
                    let matchedSurveys = try self.managedContext.fetch(request)
                    matchedSurveys[0].plus(rating: rating)
                    
                    try self.managedContext.save()
                    promise(.success(()))
                } catch {
                    promise(.failure(error))
                }
                
            }
        }.eraseToAnyPublisher()
    }
    
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

private extension DbSurvey {
    
    func plus(rating: Rating) {
        switch rating {
        case .excellent:
            self.excellent += 1
        case .good:
            self.good += 1
        case .bad:
            self.bad += 1
        case .disaster:
            self.disaster += 1
        }
    }

    func toDomain() -> Survey? {
        if let id = id, let name = name, let question = question {
            return Survey(id: id, name: name, question: question, excellent: Int(excellent), good: Int(good), bad: Int(bad), disaster: Int(disaster))
        } else {
            return nil
        }
    }
}

private class CollectionDataObserver: NSObject, NSFetchedResultsControllerDelegate {

    private let controller: NSFetchedResultsController<DbSurvey>
    let subject = CurrentValueSubject<[DbSurvey], Never>([])

    init(database: Database) {
        let request: NSFetchRequest<DbSurvey> = DbSurvey.fetchRequest()
        request.sortDescriptors = [
            NSSortDescriptor(key: "name", ascending: true, selector: #selector(NSString.localizedStandardCompare(_:))),
        ]
        
        controller = NSFetchedResultsController(fetchRequest: request, managedObjectContext: database.mainContext, sectionNameKeyPath: nil, cacheName: nil)
        super.init()
        controller.delegate = self
        try? controller.performFetch()
        
        subject.send(controller.fetchedObjects ?? [])
    }

    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        propagateLatest(with: controller)
    }
    
    private func propagateLatest(with controller: NSFetchedResultsController<NSFetchRequestResult>) {
        let fetchedObjects = controller.fetchedObjects ?? []
        subject.send(fetchedObjects.compactMap { $0 as? DbSurvey })
    }
}
