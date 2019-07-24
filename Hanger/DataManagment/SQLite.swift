//
//  SQLite.swift
//  Hanger
//
//  Created by Sean Corcoran on 7/23/19.
//  Copyright © 2019 SeanCorcoran. All rights reserved.
//

import Foundation
import SQLite3

enum SQLiteError: Error {
    case OpenDatabaseError(message: String)
    case PrepareError(message: String)
    case StepError(message: String)
    case BindError(message: String)
}

protocol SQLTable {
    static var createStatement: String { get }
}

class SQLiteDatabase {
    private let dbPointer: OpaquePointer?
    
    private init(dbPointer: OpaquePointer?) {
        self.dbPointer = dbPointer
    }
    
    fileprivate var errorMessage: String {
        if let errorPointer = sqlite3_errmsg(dbPointer) {
            let errorMessage = String(cString: errorPointer)
            return errorMessage
        } else {
            return "No error message provided from sqlite."
        }
    }
    
    deinit {
        sqlite3_close(dbPointer)
    }
    
    static func open(path: String) throws -> SQLiteDatabase {
        var db: OpaquePointer? = nil
        
        if sqlite3_open(path, &db) == SQLITE_OK {
            return SQLiteDatabase(dbPointer: db)
        } else {
            defer {
                if db != nil {
                    sqlite3_close(db)
                }
            }
            if let errorPointer = sqlite3_errmsg(db) {
                let message = String.init(cString: errorPointer)
                throw SQLiteError.OpenDatabaseError(message: message)
            } else {
                throw SQLiteError.OpenDatabaseError(message: "No error message provided from sqlite.")
            }
        }
    }
    
    func createTable(table: SQLTable.Type) throws {
        let createTableStatement = try prepareStatement(sql: table.createStatement)
        defer {
            sqlite3_finalize(createTableStatement)
        }
        guard sqlite3_step(createTableStatement) == SQLITE_DONE else {
            throw SQLiteError.StepError(message: errorMessage)
        }
        print("\(table) table created.")
    }
    
    func prepareStatement(sql: String) throws -> OpaquePointer? {
        var statement: OpaquePointer? = nil
        guard sqlite3_prepare_v2(dbPointer, sql, -1, &statement, nil) == SQLITE_OK else {
            throw SQLiteError.PrepareError(message: errorMessage)
        }
        return statement
    }
}


