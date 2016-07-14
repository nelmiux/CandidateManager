//
//  Candidate.swift
//
//  Created by Nelma Perera.
//  Copyright © 2016 Nelma Perera. All rights reserved.
//

import Foundation

class Candidate {
    
    private var _firstName:String = ""
    private var _lastName:String = ""
    private var _politicalParty:String = ""
    private var _state:String = ""
    private var _votes:Int = 0
    
    var firstName:String {
        get {
            return _firstName
        }
        set (newValue) {
            _firstName = newValue
        }
    }
    
    var lastName:String {
        get {
            return _lastName
        }
        set (newValue) {
            _lastName = newValue
        }
    }
    
    var politicalParty:String {
        get {
            return _politicalParty
        }
        set (newValue) {
            _politicalParty = newValue
        }
    }
    
    var state:String {
        get {
            return _state
        }
        set (newValue) {
            _state = newValue
        }
    }
    
    var votes:Int {
        get {
            return _votes
        }
        set(newVal) {
            _votes = newVal
        }
    }
    
    init(firstName:String, lastName:String, politicalParty:String, state:String, votes: Int) {
        self.firstName = firstName
        self.lastName = lastName
        self.politicalParty = politicalParty
        self.state = state
        self.votes = votes
    }
    
    convenience init() {
        self.init(firstName:"<NoFirstName>", lastName:"<NoLastName>", politicalParty:"<NoPoliticalParty>", state:"<NoState>", votes: 0)
    }
    
    func fullName() -> String {
        return "\(firstName) \(lastName)"
    }
    
    func fullNameAndVotes() -> String {
        return "\(self.fullName())  \(votes)"
    }
    
    func addVote() {
        self.votes += 1
    }
}