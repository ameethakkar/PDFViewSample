//
//  ViewController.swift
//  PDFViewSample
//
//  Created by Amee Thakkar on 8/7/18.
//  Copyright © 2018 Amee Thakkar. All rights reserved.
//

import UIKit
import PDFKit

class ViewController: UIViewController {

    @IBOutlet weak var pdfView: PDFView!
    
    @IBOutlet weak var pdfThumbnailView: PDFThumbnailView!
    
    let urlString = "http://www.sonyclassics.com/awards-information/whiplash_screenplay.pdf"
    
    // MARK: - Constants
    
    let thumbnailDimension = 40
    let animationDuration: TimeInterval = 0.25
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }

    func setup() {
        setupPDFView()
        setupThumbnailView()
        loadPDF()
    }
    
    func setupPDFView() {
        pdfView.autoScales = true
        pdfView.displayMode = .singlePage
        pdfView.displayDirection = .horizontal
        pdfView.displaysAsBook = true
        pdfView.usePageViewController(true, withViewOptions: nil)
        
        view.addSubview(pdfView)
    }
    
    func setupThumbnailView() {
        pdfThumbnailView.pdfView = pdfView
        pdfThumbnailView.thumbnailSize = CGSize(width: thumbnailDimension, height: thumbnailDimension)
        pdfThumbnailView.layoutMode = .horizontal
        pdfThumbnailView.backgroundColor = UIColor.lightGray
    }
    
    func loadPDF() {
        
        guard let url = Bundle.main.url(forResource: "whiplash_screenplay", withExtension: "pdf") else {
//            guard let url = URL(string : self.urlString) else {
                print("I am in else")
                return }
            print("url: \(url)")
//        DispatchQueue.global().async {
//         autoreleasepool { () -> Result in
            if let pdfDocument = PDFDocument(url: url) {
                print(pdfDocument)
//                DispatchQueue.main.async {
                    self.pdfView.document = pdfDocument
//                }
//            }
        }
        
        
        //        guard let url = pdfURL else { return }
        //        let document = PDFDocument(url: url)
        //        pdfView.document = document
        //        resetNavigationButtons()
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        coordinator.animate(alongsideTransition: { _ in
            self.scalePDFViewToFit()
        }, completion: nil)
    }
    
    func scalePDFViewToFit() {
        UIView.animate(withDuration: animationDuration) {
            self.pdfView.scaleFactor = self.pdfView.scaleFactorForSizeToFit
            self.view.layoutIfNeeded()
        }
    }

    


}

