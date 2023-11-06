//
//  Bag.swift
//  eDepositBag
//
//  Created by Jake Vigeant on 11/2/23.

import Foundation
class Bag : ObservableObject{
    static let fileManager = FileManager.default
    static let sandboxUser = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent("myProfile.json")
    let decoder = JSONDecoder()
    let encoder = JSONEncoder()

    @Published var cashier: Person?
    @Published var department: String = ""
    @Published var retailLocation: String = ""
    @Published var POSName: String = ""
    @Published var bagNum: Int?
    @Published var imageScans: [String:String] = [:]
    @Published var revenueDate: String = ""
    

    //load Person object from saved user
    func load(url :URL) -> Bool{
       
       //location of the url passed in
       print("Loading from: \(url.path)")
       let tempData: Data
       //check if the url passed exists.
       if Bag.fileManager.fileExists(atPath: url.path){
           do {
               tempData = try Data(contentsOf: url)
//               print(tempData)
//               if tempData.count == 0{
//                   print("hi")
//               }
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

}
