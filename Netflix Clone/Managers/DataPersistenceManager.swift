import Foundation
import UIKit
import CoreData

enum DataBaseError: Error {
    case failedToSaveData
    case failedToFetchData
    case failedToDeleteData
}


class DataPersistenceManager {
    
    static let shared = DataPersistenceManager()
    
    func downloadTitleWith(model: Title, completion: @escaping (Result<Void, Error>) -> Void) {
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let context = appDelegate.persistentContainer.viewContext
        
        let savedItem = TitleItem(context: context)
        
        savedItem.id = Int64(model.id)
        savedItem.media_type = model.media_type
        savedItem.original_name = model.original_name
        savedItem.original_title = model.original_title
        savedItem.poster_path = model.poster_path
        savedItem.overview = model.overview
        savedItem.vote_count = Int64(model.vote_count)
        savedItem.release_date = model.release_date
        savedItem.vote_average = model.vote_average
        
        do {
            try context.save()
            completion(.success(()))
        } catch {
            completion(.failure(DataBaseError.failedToSaveData))
        }
    }
    
    func fetchTitlesFromDataBase(completion: @escaping (Result<[TitleItem], Error>) -> Void) {
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let context = appDelegate.persistentContainer.viewContext
        
        let request: NSFetchRequest<TitleItem>
        request = TitleItem.fetchRequest()
        
        do {
            let titlesFromDataBase = try context.fetch(request)
            completion(.success(titlesFromDataBase))
        } catch {
            completion(.failure(DataBaseError.failedToFetchData))
        }
    }
    
    func deleteTitleWith(model: TitleItem, completion: @escaping (Result<Void, Error>) -> Void) {
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let context = appDelegate.persistentContainer.viewContext
        context.delete(model)
        
        do {
            try context.save()
            completion(.success(()))
        } catch {
            completion(.failure(DataBaseError.failedToDeleteData))
        }
    }
    
}
