//
//  ViewController.swift
//  SearchApp
//
//  Created by JOEL CRAWFORD on 9/7/20.
//  Copyright © 2020 JOEL CRAWFORD. All rights reserved.
//

import UIKit
import PDFKit

class ViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var navBar: UINavigationBar!
    @IBOutlet weak var searchField: UITextField!
    
    
    let pdfView = PDFView()
    
    var document: PDFDocument?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        searchField.delegate = self
        
        pdfView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(pdfView)
        //https://www.youtube.com/watch?v=2fRbC7iuvec
        
        //ADDING CONTSTRAINTS TO THE PDF VIEW
        pdfView.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor).isActive = true
        
        pdfView.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor).isActive = true
        
        pdfView.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor).isActive = true
        
        pdfView.topAnchor.constraint(equalTo: navBar.bottomAnchor).isActive = true
        
        
        
        guard let path = Bundle.main.url(forResource: "ENERGY STAR", withExtension: "pdf") else { return }
        
        document = PDFDocument(url: path)
        
        pdfView.document = document
        
        pdfView.autoScales = true
        
        pdfView.displayMode = .singlePageContinuous
        
        pdfView.displayDirection = .vertical
        
        
        
        
        
        
        
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if let textFieldString = searchField.text, let swtRange = Range(range, in: textFieldString){
            let fullString = textFieldString.replacingCharacters(in: swtRange, with: string)
            
            print("Full string: \(fullString)")
            
            let selection = pdfView.document?.findString(fullString, withOptions: .caseInsensitive)
            
            selection?.forEach { selection in
                selection.pages.forEach { page in
                    let bounds = selection.bounds(for: page)
                    
                    let highLight = PDFAnnotation(bounds: bounds, forType: .highlight, withProperties: nil)
                    
                    highLight.endLineStyle = .square
                    
                    highLight.color = UIColor.orange.withAlphaComponent(0.5)
                    
                    page.addAnnotation(highLight)
                } }
        }
        
       
        
        return true
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
}

