//
//  MementosTableViewController.swift
//  Mementos
//
//  Created by hijos on 23/4/18.
//  Copyright © 2018 Carlos de la Herrán. All rights reserved.
//

import UIKit
import CoreData

class MementosTableViewController: CoreDataTableViewController {
    
    @IBAction func newNote(_ sender: Any) {
        let _ = Note(text: "A New Note", inContext: CoreDataContainer.default.viewContext)
        // El context envía una notificación, con tres arrays (objetos eliminados, editados y recién creados)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Creo mi FetchedResultsController
        let noteRequest = Note.fetchRequest()
        noteRequest.fetchBatchSize = 100
        noteRequest.sortDescriptors = [NSSortDescriptor(key: NoteAttributes.text.rawValue, ascending: true),
                                        NSSortDescriptor(key: NoteAttributes.creationDate.rawValue, ascending: false)]
        
        let fetchRC = NSFetchedResultsController(fetchRequest: noteRequest,
                                                               managedObjectContext: CoreDataContainer.default.viewContext,
                                                               sectionNameKeyPath: nil,
                                                               cacheName: nil)
        
        // sectionNameKeyPath: clave que determina el nombre de la sección
        // cacheName: antes se hacía caché para ne estar siempre atacando a base de datos, ahora da un poco igual
        
        self.fetchedResultsController = fetchRC
        
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellID = "noteCell"
        // Averiguar la nota
        let note = self.fetchedResultsController?.object(at: indexPath) as! Note
        
        // Conseguir una celda
        var cell : UITableViewCell?
        cell = tableView.dequeueReusableCell(withIdentifier: cellID)
        
        if cell == nil {
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: cellID)
        }
        
        // Configurar a la susodicha
        cell?.textLabel?.text = note.text
        cell?.imageView?.image = note.photo?.image
        
        
        // Devolverla
        return cell!
    }
}
