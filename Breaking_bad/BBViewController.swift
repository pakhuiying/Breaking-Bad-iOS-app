//
//  BBViewController.swift
//  Breaking_bad
//
//  Created by HUI YING on 29/6/20.
//  Copyright © 2020 HUI YING. All rights reserved.
//

import UIKit

class BBViewController: UIViewController {
    //create IBOutlets and link it up to the labels in view controller
    var url: String!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var nicknameLabel: UILabel!
    @IBOutlet var char_idLabel: UILabel!
    @IBOutlet var characterImage: UIImageView!
    @IBOutlet var characterquote: UITextView!
    var character: Character!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameLabel.text = character.name
        nicknameLabel.text = "Nickname: " + character.nickname
        char_idLabel.text = String(format: "#%03d",character.char_id)
        characterquote.text = ""
        loadImage()
        loadQuotes()
    }
    
    func loadImage() {
        do {
            let imageData = try Data(contentsOf: URL(string: character.img)!)
            self.characterImage.image = UIImage(data: imageData)
        }
        
        catch {
            print(error)
        }
    }
    
    func loadQuotes() {
        let name_url = character.name.replacingOccurrences(of: " ", with: "+")
        let url = "https://www.breakingbadapi.com/api/quote/random?author=" + name_url
        
        URLSession.shared.dataTask(with: URL(string: url)!) { (data, response, error) in
            guard let data = data else {
                return
            }
            
            do {
                let quotes = try JSONDecoder().decode([CharacterQuotes].self, from: data)
                DispatchQueue.main.async {
                    for q in quotes {
                        self.characterquote.text = q.quote
                    }
                }
            }
            
            catch let error {
                print(error)
            }
        }.resume()
        
        //self.characterquote.text = url
    }
    
}
