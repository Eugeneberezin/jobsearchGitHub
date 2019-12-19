//
//  JobDetailsViewController.swift
//  GitHubJobSearch
//
//  Created by Eugene Berezin on 12/15/19.
//  Copyright © 2019 Eugene Berezin. All rights reserved.
//

import UIKit
import SafariServices

class JobDetailsViewController: UIViewController {
    
    var jobResult: Result! {
        didSet {
            companyleLabel.text = jobResult.company
            titleLabel.text = jobResult.title
            typeLabel.text = jobResult.type
            locationLabel.text = jobResult.location
            guard let url = URL(string: jobResult.company_logo ?? "") else { return }
            logoImageView.sd_setImage(with: url)
            companyURL = jobResult.company_url ?? ""
            htmlText = jobResult.description ?? ""
            let descriptionTHML = convertHTML(text: htmlText, attributedText: &descriptionTextView.attributedText)
            descriptionTextView.attributedText = descriptionTHML
            applyURL = jobResult.url ?? ""
            print("URL>>>>>>> ", applyURL)
            
        }
    }
    

    
    let logoImageView = AspectFitImageView(image: UIImage(named: "JRSTIux"), cornerRadius: 12)
    
    let companyleLabel: UILabel = {
        let label = UILabel()
        label.text = "Awesome Company"
        label.font = .boldSystemFont(ofSize: 17)
        return label
    }()
    
    let titleLabel: UILabel = {
         let label = UILabel()
         label.text = "iOS developer"
         label.font = .systemFont(ofSize: 16)
         return label
     }()
    
    let typeLabel: UILabel = {
           let label = UILabel()
           label.text = "Full time"
           label.font = .systemFont(ofSize: 16)
           label.textColor = .label
           return label
       }()
    
    let urlButton: UIButton = {
        let button = UIButton(type: .system)
         button.backgroundColor = .systemBlue
         button.setTitle("Visit Company's Website", for: .normal)
         button.tintColor = .white
         button.backgroundColor = UIColor(named: "buttonColor")
         button.layer.cornerRadius = 15
        button.addTarget(self, action: #selector(handleCompanyWebsite), for: .touchUpInside)
         return button
     }()
    
    var companyURL = ""
    var applyURL = ""
    
    @objc func handleCompanyWebsite() {

        guard let url = URL(string: companyURL) else { return }
        let svc = SFSafariViewController(url: url)
        self.present(svc, animated: true)
        print("THIS IS COMPANY URL>>>  ",url)
        
    }
    
    let locationLabel: UILabel = {
         let label = UILabel()
         label.text = "Seattle, WA"
         label.font = .systemFont(ofSize: 16)
         return label
     }()
    
    
    var htmlText = """
                       
                   """
    
    
    func convertHTML(text: String,  attributedText: inout NSAttributedString) -> NSAttributedString  {
        let data = Data(text.utf8)
        let options: [NSAttributedString.DocumentReadingOptionKey: Any] = [
            .documentType: NSAttributedString.DocumentType.html,
            .characterEncoding: String.Encoding.utf8.rawValue
        ]
        
        if let attributedString = try? NSMutableAttributedString(data: data, options: options, documentAttributes: nil) {
            attributedText = attributedString
            
            return attributedString
        }
        let colorAttribute: [NSAttributedString.Key: Any] = [.foregroundColor: UIColor(named: "textColor")]
        

        return attributedText
    }
    
    
    

    let descriptionTextView: UITextView = {
        let textView = UITextView()
        textView.font = .systemFont(ofSize: 14)
        textView.textAlignment = .left
        textView.backgroundColor = UIColor(named: "textView")
        textView.isEditable = false
        textView.layer.cornerRadius = 12
        return textView
    }()
    
    
    let applyButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .systemBlue
        button.setTitle("Apply", for: .normal)
        button.backgroundColor = UIColor(named: "buttonColor")
        button.tintColor = .white
        button.layer.cornerRadius = 15
        button.addTarget(self, action: #selector(handleApply), for: .touchUpInside)
        return button
    }()
    
    @objc func handleApply() {
        guard let url = URL(string: applyURL) else { return }
        let svc = SFSafariViewController(url: url)
        self.present(svc, animated: true)
        print("THIS IS APPLY URL >>", url)
    }
    
    
    var pinchGesture = UIPinchGestureRecognizer()
    
    @objc func pinchText(sender: UIPinchGestureRecognizer) {
        var pointSize = descriptionTextView.font?.pointSize
        pointSize = ((sender.velocity > 0) ? 1 : -1) * 1 + pointSize!;
        descriptionTextView.font = UIFont( name: "arial", size: (pointSize)!)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pinchGesture = UIPinchGestureRecognizer(target: self, action:#selector(pinchText(sender:)))
        descriptionTextView.addGestureRecognizer(pinchGesture)
        view.backgroundColor = UIColor(named: "cardColor")
        view.addSubview(logoImageView)
        logoImageView.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: nil, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 10, left: 10, bottom: 0, right: 10), size: .init(width: 80, height: 100))
        
        let stackView = UIStackView(arrangedSubviews: [companyleLabel, titleLabel, typeLabel, locationLabel,urlButton
        ])
        view.addSubview(stackView)
        stackView.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: logoImageView.leadingAnchor, padding: .init(top: 10, left: 20, bottom: 20, right: 20))
        stackView.axis = .vertical
        stackView.spacing = 10
        view.addSubview(descriptionTextView)
        descriptionTextView.anchor(top: stackView.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 10, left: 20, bottom: 20, right: 20))
        view.addSubview(applyButton)
        applyButton.anchor(top: descriptionTextView.bottomAnchor, leading: view.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: view.trailingAnchor, padding: .init(top: 10, left: 70, bottom: 30, right: 70))
        

        
    }
    

    

}


