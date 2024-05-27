import Foundation
import FirebaseFirestore
import FirebaseAuth

class FireDBHelper : ObservableObject {
    @Published var movieOrder: [MovieOrder] = []
    @Published var bookedChair: [BookedChair] = []
    private let db : Firestore
    private static var shared : FireDBHelper?
    private let COLLECTION_USER    : String = "User"
    private let COLLECTION_MOVIES  : String = "Movies"
    private let COLLECTION_BOOKED_CHAIR  : String = "BookedChair"
    
    init(db : Firestore){
        self.db = db
    }
    
    static func getInstance() -> FireDBHelper{
        if (shared == nil){
            shared = FireDBHelper(db: Firestore.firestore())
        }
        
        return shared!
    }
    
    func createUser(userID userID: String, name name:String, email email:String){
        let userProfile = Users(name: name , email: email)
        do{
            try self.db
                .collection(COLLECTION_USER)
                .document(userID)
                .setData(from: userProfile)
        } catch let err as NSError{
            print(#function, "unable to create user into database")
        }
    }
    
    func getUser() async -> Users?{
        do {
            return try await self.db
                .collection(COLLECTION_USER)
                .document(Auth.auth().currentUser?.uid ?? "")
                .getDocument(as: Users.self)
        }catch let err as NSError{
            print(#function, "unable to get the user profile: \(err)")
        }
        return nil
    }
    
    func updateUserName(name userName: String){
        do{
            try self.db
                .collection(COLLECTION_USER)
                .document(Auth.auth().currentUser?.uid ?? "")
                .updateData(["name": userName])
        }catch let err as NSError {
            print(#function, "unable to update user name: \(err)")
        }
    }
    
    func updateEmail(email userEmail: String){
        do{
            try self.db
                .collection(COLLECTION_USER)
                .document(Auth.auth().currentUser?.uid ?? "")
                .updateData(["email": userEmail])
        }catch let err as NSError {
            print(#function, "unable to update user email: \(err)")
        }
    }
    
    func insertMovie(newMovie : MovieOrder, updateSelectedSeat: [Seat]) async {
        let loggedInUserEmail = UserDefaults.standard.string(forKey: "KEY_EMAIL") ?? ""
        var existMovieChairID : String?
        
        if (loggedInUserEmail.isEmpty){
            print(#function, "Logged in user information not available. Can't add the book")
        }else{
            
            do{
                try self.db
                    .collection(COLLECTION_USER)
                    .document(Auth.auth().currentUser?.uid ?? "")
                    .collection(COLLECTION_MOVIES)
                    .addDocument(from: newMovie)
            }catch let err as NSError{
                print(#function, "Unable to add document to firestore : \(err.localizedDescription)")
            }
            
            do{
                let querySnapshot = try await db.collection(COLLECTION_BOOKED_CHAIR)
                    .whereField("title", isEqualTo: newMovie.title)
                    .whereField("cinema", isEqualTo: newMovie.cinema)
                    .whereField("date", isEqualTo: newMovie.date)
                    .whereField("hour", isEqualTo: newMovie.hour)
                    .getDocuments()
                
                for doc in querySnapshot.documents{
                    existMovieChairID = doc.documentID
                }
            }catch let err as NSError{
                print(#function, "Unable to get specific field document to firestore : \(err.localizedDescription)")
            }
            
            if let id = existMovieChairID{
                do{
                    try await self.db
                        .collection(COLLECTION_BOOKED_CHAIR)
                        .document(existMovieChairID!)
                        .updateData(["selectedSeat" : updateSelectedSeat.map{["seatNum" : $0.seatNum]}])
                }catch let err as NSError{
                    print(#function, "Unable to update document to firestore: \(err.localizedDescription)")
                }
            }else{
                do{
                    try self.db
                        .collection(COLLECTION_BOOKED_CHAIR)
                        .addDocument(from: BookedChair(title: newMovie.title,
                                                       cinema: newMovie.cinema,
                                                       date: newMovie.date,
                                                       hour: newMovie.hour,
                                                       selectedSeats: newMovie.selectedSeats))
                }catch let err as NSError{
                    print(#function, "Unable to add document to firestore : \(err)")
                }
            }
        }
    }
    
    func getAllMovies(){
        self.movieOrder.removeAll()
        
        self.db.collection(COLLECTION_USER)
            .document(Auth.auth().currentUser?.uid ?? "")
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
                            print(#function, "Document updated : \(docChange.document.documentID)")
                            if (matchedIndex != nil){
                                self.movieOrder[matchedIndex!] = movie
                            }
                        case .removed:
                            print(#function, "Document removed : \(docChange.document.documentID)")
                            if (matchedIndex != nil){
                                self.movieOrder.remove(at: matchedIndex!)
                            }
                        }
                        
                    }catch let err as NSError{
                        print(#function, "Unable to convert document into Swift object : \(err)")
                    }
                } //forEach
            }) //addSnapshotListener
        //        }
    }//getAllMovies
    
    func insertBookedChair(bookedChair: BookedChair){
        let loggedInUserEmail = UserDefaults.standard.string(forKey: "KEY_EMAIL") ?? ""
        
        if (loggedInUserEmail.isEmpty){
            print(#function, "Logged in user information not available. Can't add the booked chair")
        }else{
            do{
                try self.db
                    .collection(COLLECTION_BOOKED_CHAIR)
                    .addDocument(from: bookedChair)
            }catch let err as NSError{
                print(#function, "Unable to add document to firestore : \(err)")
            }
        }
    }
    
    func getUnavailableChair(movieTitle:String, cinema:String, date: String, hour:String) async  {
        do{
            let querySnapshot = try await db.collection(COLLECTION_BOOKED_CHAIR)
                .whereField("title", isEqualTo: movieTitle)
                .whereField("cinema", isEqualTo: cinema)
                .whereField("date", isEqualTo: date)
                .whereField("hour", isEqualTo: hour)
                .getDocuments()
            
            if querySnapshot.documents.isEmpty {
                  bookedChair.removeAll()
                print(#function, "Empty documents list")
              } else {
                  bookedChair.removeAll()
                  var tempBookedChairlist : [BookedChair] = []
                  for document in querySnapshot.documents {
                      if let bookedChair = try? document.data(as: BookedChair.self) {
                          tempBookedChairlist.append(bookedChair)
                      }
                  }
                self.bookedChair = tempBookedChairlist
                  
              }
        }catch {
            print(#function, "Error getting documents: \(error.localizedDescription)")
        }
    }
}
