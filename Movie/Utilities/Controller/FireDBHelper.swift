import Foundation
import FirebaseFirestore

class FireDBHelper : ObservableObject {
    @Published var movieOrder = [MovieOrder]()
    var fireAuthHelper = FireAuthHelper()
    
    private let db : Firestore
    private static var shared : FireDBHelper?
    private let COLLECTION_USER    : String = "User"
    private let COLLECTION_MOVIES  : String = "Movies"
    
    init(db : Firestore){
        self.db = db
    }
    
    static func getInstance() -> FireDBHelper{
        if (shared == nil){
            shared = FireDBHelper(db: Firestore.firestore())
        }
        
        return shared!
    }
    
    func insertMovie(newMovie : MovieOrder){
        let loggedInUserEmail = UserDefaults.standard.string(forKey: "KEY_EMAIL") ?? ""
        
        if (loggedInUserEmail.isEmpty){
            print(#function, "Logged in user information not available. Can't add the book")
        }else{
            
            do{
                try self.db
                    .collection(COLLECTION_USER)
                    .document(loggedInUserEmail)
                    .collection(COLLECTION_MOVIES)
                    .addDocument(from: newMovie)
            }catch let err as NSError{
                print(#function, "Unable to add document to firestore : \(err)")
            }
        }
    }
    
    func getAllMovies(){
        let loggedInUserEmail = UserDefaults.standard.string(forKey: "KEY_EMAIL") ?? ""
        
        if (loggedInUserEmail.isEmpty){
            print(#function, "Logged in user information not available. Can't add the book")
        }else{
            
            self.db.collection(COLLECTION_USER)
                .document(loggedInUserEmail)
                .collection(COLLECTION_MOVIES)
                .addSnapshotListener({ (querySnapshot, error) in
                    
                    guard let snapshot = querySnapshot else{
                        print(#function, "Unable to retrieve data from firestore : \(error)")
                        return
                    }
                    
                    snapshot.documentChanges.forEach{ (docChange) in
                        
                        do{
                            
                            var movie : MovieOrder = try docChange.document.data(as: MovieOrder.self)
                            movie.id = docChange.document.documentID
                            
                            let matchedIndex = self.movieOrder.firstIndex(where: {($0.id?.elementsEqual(docChange.document.documentID))!})
                            
                            switch(docChange.type){
                            case .added:
                                print(#function, "Document added : \(docChange.document.documentID)")
                                self.movieOrder.append(movie)
                            case .modified:
                                //replace existing object with updated one
                                print(#function, "Document updated : \(docChange.document.documentID)")
                                if (matchedIndex != nil){
                                    self.movieOrder[matchedIndex!] = movie
                                }
                            case .removed:
                                //remove object from index in movieOrder
                                print(#function, "Document removed : \(docChange.document.documentID)")
                                if (matchedIndex != nil){
                                    self.movieOrder.remove(at: matchedIndex!)
                                }
                            }
                            
                        }catch let err as NSError{
                            print(#function, "Unable to convert document into Swift object : \(err)")
                        }
                        
                    }//forEach
                })//addSnapshotListener
        }
    }//getAllBooks
    
//    func deleteBook(MovieToDelete : MovieOrder){
//        let loggedInUserEmail = UserDefaults.standard.string(forKey: "KEY_EMAIL") ?? ""
//        
//        if (loggedInUserEmail.isEmpty){
//            print(#function, "Logged in user information not available. Can't add the book")
//        }else{
//            self.db.collection(COLLECTION_USER)
//                .document(loggedInUserEmail)
//                .collection(COLLECTION_MOVIES)
//                .document(bookToDelete.id!)
//                .delete{error in
//                    if let err = error{
//                        print(#function, "Unable to delete document : \(err)")
//                    }else{
//                        print(#function, "successfully deleted : \(bookToDelete.title)")
//                    }
//                }
//        }
//    }
//    
//    func updateBook(bookToUpdate : MovieOrder){
//        let loggedInUserEmail = UserDefaults.standard.string(forKey: "KEY_EMAIL") ?? ""
//        
//        if (loggedInUserEmail.isEmpty){
//            print(#function, "Logged in user information not available. Can't add the book")
//        }else{
//            self.db.collection(COLLECTION_LIBRARY)
//                .document(loggedInUserEmail)
//                .collection(COLLECTION_BOOKS)
//                .document(bookToUpdate.id!)
//                .updateData([FIELD_TITLE: bookToUpdate.title,
//                            FIELD_AUTHOR: bookToUpdate.author,
//                         FIELD_ISFICTION: bookToUpdate.isFiction]){ error in
//                    
//                    if let err = error{
//                        print(#function, "Unable to update document : \(err)")
//                    }else{
//                        print(#function, "successfully updated : \(bookToUpdate.title)")
//                    }
//                }
//        }
//    }
}
