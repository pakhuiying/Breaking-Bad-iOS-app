//
//  ViewController.swift
//  Breaking_bad
//
//  Created by HUI YING on 28/6/20.
//  Copyright © 2020 HUI YING. All rights reserved.
//

import UIKit

class ViewController: UITableViewController, UISearchBarDelegate {
    var characters: [Character] = []
    
    @IBOutlet var searchcharacter: UISearchBar!
    
    var filteredCharacters = [Character]()
    
    override func viewDidLoad() {
        tableView.dataSource = self
        super.viewDidLoad()
        /*let searchBar:UISearchBar = UISearchBar()
        searchcharacter.searchBarStyle = UISearchBar.Style.prominent
        searchcharacter.placeholder = " Search..."
        searchcharacter.sizeToFit()
        searchcharacter.isTranslucent = false
        searchcharacter.backgroundImage = UIImage()*/
        searchcharacter.delegate = self //delegate searchbar to viewDidLoad
        
        //filteredCharacters = characters
        
        guard let url = URL(string: "https://www.breakingbadapi.com/api/characters")
            else {
                return
                
        }
        
        URLSession.shared.dataTask(with: url){(data, response, error) in
            guard let data = data else {
                return
            }
            do {
                let characterList = try JSONDecoder().decode([Character].self, from: data)
                self.characters = characterList
                self.filteredCharacters = self.characters
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
                
            }
            catch let error {
                print("\(error)")
            }
            
        }.resume()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1 //1 section
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        /*if searchcharacter.text!.isEmpty {
            return characters.count
        }*/
        
        return filteredCharacters.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CharacterCell", for: indexPath)
        cell.textLabel?.text = filteredCharacters[indexPath.row].name //?->if nil, dont crash, carry on
        return cell
    }
    
    //segue to transition between view controllers
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "CharacterSegue",
            //when u click on a row it should link to next page->PokemonViewController
                let destination = segue.destination as? BBViewController ,
            //index of pokemon will correspond to the row number
                let index = tableView.indexPathForSelectedRow?.row {
            destination.character = filteredCharacters[index]
        }
        
        /*if segue.identifier == "CharacterSegue" {
            //destination is of type BBViewController
            if let destination = segue.destination as? BBViewController {
                //index into list, getting item that corresponds to row that user, selected, passing it to view controller
                destination.character = filteredCharacters[tableView.indexPathForSelectedRow!.row]
            }
        }*/
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange textSearched: String) {
        filteredCharacters = textSearched.isEmpty ? characters : characters.filter{(characters: Character) -> Bool in return characters.name.lowercased().contains(textSearched.lowercased())
            
        }
        
        
        tableView.reloadData()
    }

}

