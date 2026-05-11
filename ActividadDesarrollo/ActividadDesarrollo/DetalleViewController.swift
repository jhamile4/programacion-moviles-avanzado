//
//  DetalleViewController.swift
//  ActividadDesarrollo
//
//  Created by Tecsup on 27/04/26.
//

import UIKit

class DetalleViewController: UIViewController {
    @IBOutlet weak var imgCultura: UIImageView!
    @IBOutlet weak var lblNombre: UILabel!
    @IBOutlet weak var lblRegion: UILabel!
    @IBOutlet weak var lblDescripcion: UITextView!
    
    var culturaRecibida: Cultura?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let cultura = culturaRecibida {
            self.title = cultura.nombre
            lblNombre.text = cultura.nombre
            lblRegion.text = "Región: \(cultura.region)"
            lblDescripcion.text = cultura.descripcion
            imgCultura.image = UIImage(named: cultura.imagen)
        }
    }
    
    
    
}
