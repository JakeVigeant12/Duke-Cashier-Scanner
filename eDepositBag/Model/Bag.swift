//
//  Bag.swift
//  eDepositBag
//
//  Created by Jake Vigeant on 11/2/23.

import Foundation
import Combine
class Bag : NSObject, ObservableObject, URLSessionDownloadDelegate{
    static let fileManager = FileManager.default
    static let testURL = Bundle.main.url(forResource: "test_pdf", withExtension: "pdf")
    static let sandboxUser = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent("myProfile.json")
    static let selectionOptions = Bundle.main.url(forResource: "selection_options", withExtension: "json") 
    let decoder = JSONDecoder()
    let encoder = JSONEncoder()
    var cancellable: AnyCancellable?
    
    @Published var progress: Float = 0.0
    @Published var downloadComplete: Bool = false
    @Published var downloadError: Bool = false
    @Published var errorText:String = ""

    // Deployed server Location
    let SERVER_BASE = "https://edeposit-backend-aa3d55395f8f.herokuapp.com/"

    @Published var cashier: Person?
    @Published var department: String = ""
    @Published var retailLocation: String = ""
    @Published var POSName: String = ""
    @Published var bagNum: Int = 0
    @Published var imageScans: [String:String] = [:]
    @Published var revenueDate: String = ""
    @Published var messages: [Message] = []

    var departments: [String] = []
    var locationSelections: [String:[String]] = [:]
    var POSNameSelections: [String:[String]] = [:]

    override init() {
            super.init()
        }


    // DOWNLOAD DELEGATE METHODS
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didWriteData bytesWritten: Int64, totalBytesWritten: Int64, totalBytesExpectedToWrite: Int64) {
            progress = Float(totalBytesWritten) / Float(totalBytesExpectedToWrite)
            DispatchQueue.main.async {
            //self.ProgressBar.setProgress(progress, animated: true)
        }
        }
    
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
        print("Download completed. File saved at: \(location.absoluteString)")
        do {
            let data = try Data(contentsOf: location)
            
            do{
                    if let decoded = try? decoder.decode([Message].self, from: data) {
                        self.messages = decoded
                        downloadComplete = true
                        progress = 0.0
                        print("Added messages")
                    }
                else{
                   print("Problem Parsing")
                }
                }
       
        }
        catch{
            downloadError = true
            print("Error retrieving downloaded data.")
        }
        
            
        
    }
        
    func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
            if let error = error {
                downloadError = true
                errorText = error.localizedDescription
            } else {
                print("Download task completed successfully.")
            }
        }
    
    // drop saved user from current instance
    func logout() {
        cashier = nil
    }
    
    //load Person object from saved user in sandbox
    func load(url :URL) -> Bool{
       
       //location of the url passed in
       print("Loading from: \(url.path)")
       let tempData: Data
       //check if the url passed exists.
       if Bag.fileManager.fileExists(atPath: url.path){
           do {
               tempData = try Data(contentsOf: url)
               print(tempData)
               if tempData.count == 0{
                   print("hi")
               }
           } catch let error as NSError {
               print(error)
               return false
           }
           do {
               self.cashier = try decoder.decode(Person.self, from: tempData)
               return true
           } catch {
               return false
           }

       }
        return false
       }
    
    //update the users profile in sandbox
    func save() -> Bool {
        print("Saving to \(Bag.sandboxUser)")
        let encoder = JSONEncoder()
        do {
            let jsonData = try encoder.encode(cashier)
            try jsonData.write(to: Bag.sandboxUser)
            return true
        } catch {
            print("Error saving Use: \(error)")
            return false
        }
    }
    
    func parseOptions(url: URL) -> Bool {
        do {
            let jsonData = try Data(contentsOf: url)
            do {
                //extract all of the selection options
                if let jsonObject = try JSONSerialization.jsonObject(with: jsonData, options: []) as? [String: Any],
                   let dept = jsonObject["departments"] as? [String], let locs = jsonObject["locations"] as? [String:[String]] {
                    self.departments = dept
                    self.locationSelections = locs
                }
                return true
            } catch {
                print("Error parsing JSON: \(error)")
                return false
            }
        } catch {
            print("Error loading JSON: \(error)")
            return false
        }
    }
    
    func fetchMessages() -> Bool{
        downloadComplete = false
        downloadError = false
        errorText = ""
       print("Attempting Server Download...")
        if cashier != nil{
            let url = URL(string: (SERVER_BASE + "messages/\(cashier!.duid)"))
            var request = URLRequest(url: url!)
            let session = URLSession(configuration: .default, delegate: self, delegateQueue: .main)
            request.httpMethod = "GET"
            //     request.setValue("Basic \(auth)", forHTTPHeaderField: "Authorization")
            let httprequest = session.downloadTask(with: request as URLRequest)
            httprequest.resume()
            return true
        }
        return false

   }
    func deleteMessage(id: UUID) -> Bool{
        // remove the message from the UI
        self.messages = messages.filter { !($0.id == id) }

        // remove the message from the server
        let url = URL(string: ("\(SERVER_BASE)/messages/\(id)"))
        var request = URLRequest(url: url!)
        let session = URLSession.shared
        request.httpMethod = "DELETE"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        print("URL: \(request.url?.absoluteString ?? "None")")

        print("HTTP Method: \(request.httpMethod ?? "None")")

        print("Headers: \(request.allHTTPHeaderFields ?? [:])")
        
        let task = session.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print("Error: \(error)")
            } else if let response = response as? HTTPURLResponse {
                if response.statusCode == 200 {
                    print("DELETE request successful")
                } else {
                    print("DELETE request failed with status code: \(response.statusCode)")
                }
            }
        }
        
        task.resume()
        return false
    }

    // load user messages
//    func fetchMessages() -> AnyCancellable {
//        guard let url = URL(string: (SERVER_BASE + "messages/\(cashier!.duid)")) else {
//            print("Invalid URL")
//            return Empty().eraseToAnyPublisher().sink { _ in }
//        }
//
//        let session = URLSession.shared
//        return session.dataTaskPublisher(for: url)
//            .tryMap { (data, response) in
//                guard let httpResponse = response as? HTTPURLResponse else {
//                    print("Response Error")
//                    throw NSError(domain: NSURLErrorDomain, code: NSURLErrorBadServerResponse, userInfo: nil)
//                }
//
//                guard (200..<300).contains(httpResponse.statusCode) else {
//                    print("Unsuccessful response code.")
//                    throw NSError(domain: NSURLErrorDomain, code: NSURLErrorBadServerResponse, userInfo: nil)
//                }
//
//                return data
//            }
//            .decode(type: [Message].self, decoder: decoder)
//            .receive(on: DispatchQueue.main)
//            .sink(receiveCompletion: { completion in
//                switch completion {
//                case .finished:
//                    print("Finished Download")
//                    break
//                case .failure(let error):
//                    print("Error: \(error)")
//                }
//            }, receiveValue: { messages in
//                for message in messages {
//                    self.messages.append(message)
//                }
//            })
//    }

    


    // download Dept/Location/POSName options
    func downloadOptions() {}



    
    

}
