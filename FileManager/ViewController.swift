//  ViewController.swift
//  FileManager
//  Created by Felipe Ramírez on 10/1/22.

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var txt_2: UITextView!
    @IBOutlet weak var txt_1: UITextField!
    var datos = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func btn_leer(_ sender: Any) {
        let fileManager = FileManager.default
        if fileManager.fileExists(atPath: getFullPath().absoluteString){
            let array = getData()
            datos = array
        }else{
            print ("No existe el archivo")
        }
        txt_2.text = datos.description
        
    }
    @IBAction func btn_guardar(_ sender: Any) {
        guard let texto = txt_1.text else {return}
        let fileManager = FileManager.default
        if fileManager.fileExists(atPath: getFullPath().absoluteString){
            let array = getData()
            datos = array
        }else{
            print ("No existe")
        }
        datos.append(texto)
        
        //grabar los datos
        do{
            let datosEnJson = try JSONSerialization.data(withJSONObject: datos)
            try datosEnJson.write(to: getFullPath())
        }catch let error {
            print("ERROR: \(error)")
        }
    }
    
    private func getDocumentPath() -> URL{
        guard let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {return URL(string: "")!}
        return path
    }
    
    private func getFullPath() -> URL{
        let path = getDocumentPath()
        let fileURL = path.appendingPathComponent("datos.json")
        return fileURL
    }
    
    private func getData() -> [String]{
        do{
            let data = try Data(contentsOf: getFullPath())
            guard let array = try JSONSerialization.jsonObject(with: data) as? [String] else {return []}
            datos = array
        }catch let error {
            print("ERROR: \(error)")
        }
        return datos
    }
}

