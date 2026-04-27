//
//  ViewController.swift
//  SEMANA7
//
//  Created by Tecsup on 27/04/26.
//

import UIKit

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource{
    
    var personasArreglo=["jhamile macavilca","jose manuel arriola","mafer neyra","daniel alberto castro","daniel alberto castro"]
    var personasImagenarreglo=["imagen1","imagen2","imagen4","images3","imagen5"]
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return personasArreglo.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell=tableView.dequeueReusableCell(withIdentifier: "micell")as?PersonasTableViewCell
        cell?.personaNombre.text="\(personasArreglo[indexPath.row])"
        cell?.PersonaImagen.image=UIImage(named: "\(personasImagenarreglo[indexPath.row])")
        return cell!
        
    }
        
        
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    

}



