//
//  RealmManager.swift
//  MobileDataUsage
//
//  Created by Andrew Khoo on 12/6/20.
//  Copyright © 2020 Andrew Khoo. All rights reserved.
//

import Foundation
import RealmSwift

class RealmManager {
    let realm: Realm!
    
    init() {
        let config = Realm.Configuration(
            // Set the new schema version. This must be greater than the previously used
            // version (if you've never set a schema version before, the version is 0).
            schemaVersion: 0,

            // Set the block which will be called automatically when opening a Realm with
            // a schema version lower than the one set above
            migrationBlock: { migration, oldSchemaVersion in
                // We haven’t migrated anything yet, so oldSchemaVersion == 0
                if (oldSchemaVersion < 1) {
                    // Nothing to do!
                    // Realm will automatically detect new properties and removed properties
                    // And will update the schema on disk automatically
                }
            })

        // Tell Realm to use this new configuration object for the default Realm
        Realm.Configuration.defaultConfiguration = config
        
        // Initialize realmDB
        realm = try! Realm()
    }
    
    func addYearRecordToRealm(_ records: [YearRecord], update: Bool = true) {
        try! realm.write {
           update ? realm.add(records, update: .modified) : realm.add(records)
        }
    }
    
    func getYearRecordsFromRealm() -> [YearRecord] {
        let results: Results<YearRecord> = realm.objects(YearRecord.self)
        let yearRecords = Array(results).sorted(by: <)
        return yearRecords
    }
    
    func deleteAllData() {
        try! realm.write {
            realm.deleteAll()
        }
    }
}
