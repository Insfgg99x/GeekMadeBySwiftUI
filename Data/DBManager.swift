//
//  DBManager.swift
//  geek
//
//  Created by xgf on 2018/2/22.
//  Copyright © 2018年 xgf. All rights reserved.
//

import UIKit
import CoreData

class DBManager: NSObject {
    static let shared = DBManager.init()
    private var ctx = NSManagedObjectContext.init()
    
    override init() {
        super.init()
        setup()
    }
    private func setup() {
        var model_url=Bundle.main.url(forResource: "Model", withExtension: "momd")
        if model_url == nil {
            model_url=URL.init(string: "")
        }
        var model=NSManagedObjectModel.init(contentsOf: model_url!)
        if model == nil {
            model=NSManagedObjectModel.init()
        }
        let store=NSPersistentStoreCoordinator.init(managedObjectModel: model!)
        let db_path=NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).last! + "/data.db"
        let db_url=URL.init(fileURLWithPath: db_path)
        let options=[NSMigratePersistentStoresAutomaticallyOption:true,NSInferMappingModelAutomaticallyOption:true]
        do {
            try store.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: db_url, options: options)
        }catch let e {
            print("数据库打开失败" + e.localizedDescription)
        }
        ctx = NSManagedObjectContext.init(concurrencyType: .privateQueueConcurrencyType)
        ctx.persistentStoreCoordinator = store
    }
}
extension DBManager {
    //fetch
    func entityWithId(_ id:String?) -> Favorites? {
        guard (id != nil) else {
            return nil
        }
        let request:NSFetchRequest=Favorites.fetchRequest()
        let predicate=NSPredicate.init(format: "id=%@", id!)
        request.predicate=predicate
        var array:Array<Favorites>? = nil
        ctx.performAndWait {
            do{ try array=ctx.fetch(request) }catch{}
        }
        if array == nil || array?.count == 0{
            return nil
        }
        return array?.first
    }
    func delete(_ entity: Favorites?) {
        guard entity != nil else {
            return
        }
        ctx.performAndWait {
            ctx.delete(entity!)
        }
    }
    func deleteById(_ id:String?) {
        guard id != nil else {
            return
        }
        let entity = entityWithId(id)
        guard entity != nil else {
            return
        }
        delete(entity!)
    }
    func insert(feed:Feed?) {
        guard feed != nil, feed?.id != nil else {
            return
        }
        let tmp = entityWithId(feed?.id)
        if tmp != nil {
            return
        }
        var entity: Favorites? = nil
        ctx.performAndWait {
            entity=NSEntityDescription.insertNewObject(forEntityName: "Favorites", into: ctx) as? Favorites
        }
        guard entity != nil else {
            return
        }
        entity!.id = feed?.id
        entity!.desc = feed?.desc
        entity!.url = feed?.url
        entity!.source = feed?.source
        entity!.type = feed?.type
        if feed?.used != nil {
            entity!.used = (feed?.used)!
        }
        entity!.who = feed?.who
        entity!.publishedAt = feed?.publishedAt
        entity!.createdAt = feed?.createdAt
        entity!.collectDate = Date.init()
    }
    func entitys() -> [Favorites]? {
        let request:NSFetchRequest=Favorites.fetchRequest()
        let sort = NSSortDescriptor.init(key:"collectDate", ascending: true)
        request.sortDescriptors = [sort]
        var array:Array<Favorites>? = nil
        ctx.performAndWait {
            do{
                try array=ctx.fetch(request)
            }catch{
                
            }
        }
        if array == nil || array?.count == 0{
            return nil
        }
        return array
    }
    func save() {
        guard ctx.hasChanges else {
            return
        }
        ctx.performAndWait {
            do {
                try ctx.save()
            } catch {
                print("上下文保存失败\n")
                ctx.reset()
            }
        }
    }
}
