//
//  AnimeCoreDate.swift
//  Anime Recommendation Crud IOS
//
//  Created by Renilson Santana on 28/06/21.
//

import UIKit
import CoreData

class AnimeCoreDate: NSObject {
    
    //Recupera Context
    func getContext() -> NSManagedObjectContext{
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        let context = appDelegate?.persistentContainer.viewContext
        return context!
    }
    
    func persisteAnime(){
        let context = getContext()
        
        do{
            try context.save()
        } catch{
            print(error.localizedDescription)
        }
    }
    
    func recuperarAnimes() -> [Anime]{
        let context = getContext()
        
        do {
            let animes = try context.fetch(Anime.fetchRequest()) as! [Anime]
            if animes.count > 0{
                return animes
            }
        } catch {
            print(error.localizedDescription)
        }
        return []
    }
    
    func deletarAnime(anime: Anime){
        let context = getContext()
        
        context.delete(anime)
        
        do{
            try context.save()
        } catch{
            print(error.localizedDescription)
        }
    }

}
