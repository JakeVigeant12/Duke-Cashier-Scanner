//
//  Bag.swift
//  eDepositBag
//
//  Created by Jake Vigeant on 11/2/23.
class Bag {
    private var name: String = ""
    private var duid: Int = 0
    private var phone: Int = 0
    private var email: String = ""
    private var department: String = ""
    private var retailLocation: String = ""
    private var POSName: String = ""
    private var bagNum: Int?
    
    func barCodeScan(num: Int) {
        bagNum = num
    }
}
