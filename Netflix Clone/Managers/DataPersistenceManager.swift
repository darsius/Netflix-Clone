import Foundation
import UIKit
import CoreData


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
            completion(.failure(error))
        }
        
    }
    
    
}
