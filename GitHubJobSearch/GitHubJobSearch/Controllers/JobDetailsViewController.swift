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
    
    let logoImageView = AspectFitImageView(image: UIImage(named: "logo"), cornerRadius: 12)
    
    let companyleLabel: UILabel = {
        let label = UILabel()
        label.text = "Awesome Company"
        label.font = .systemFont(ofSize: 16)
        return label
    }()
    
    let titleLabel: UILabel = {
         let label = UILabel()
         label.text = "iOS developer"
         label.font = .systemFont(ofSize: 16)
         return label
     }()
    
    let urlButton: UIButton = {
        let button = UIButton(type: .system)
         button.backgroundColor = .systemBlue
         button.setTitle("Visit Company's Website", for: .normal)
         button.tintColor = .white
         button.layer.cornerRadius = 15
        button.addTarget(self, action: #selector(handleCompanyWebsite), for: .touchUpInside)
         return button
     }()
    
    var companyURL = ""
    let applyURL = ""
    
    @objc func handleCompanyWebsite() {

        guard let url = URL(string: "https://eugene-berezin-iosdev.com/") else { return }
        let svc = SFSafariViewController(url: url)
        self.present(svc, animated: true)
        
    }
    
    let locationLabel: UILabel = {
         let label = UILabel()
         label.text = "Seattle, WA"
         label.font = .systemFont(ofSize: 16)
         return label
     }()
    
    
    var htmlText = """
                       BabyCenter, the world's number one digital parenting resource, is seeking a talented hands-on Software Architect with a passion for building world-class experiences for over 100 million people monthly.  BabyCenter is a subsidiary of J2 Global under the Everyday Health Group’s Parenting &amp; Pregnancy vertical.</p>\n<p>As Software Architect, you will design and architect stable, scalable and secure web applications and services with state-of-the-art cloud technologies. You are a hands-on lead developer in the implementation of new solutions, prototypes, as well as actively contributing to the ideation and design phases of each project.  You will work with an inspired and inquisitive team of technologists who are already developing and deploying applications to the highest standards.</p>\n<p>You have experience building large-capacity consumer-facing web services and sites, experience working with new technologies, and a desire to build great products for new and expecting parents.</p>\n<p>This is a full-time position at our location in San Francisco, and reports to the Director of Engineering.</p>\n<p>Pursuant to the San Francisco Fair Chance Ordinance, we will consider for employment qualified applicants with arrest and conviction records.</p>\n<p>Position Overview</p>\n<p>The BabyCenter Software Architect is responsible for the construction of consumer and advertising software solutions, using a team-based approach and collaborating with all functions on the team to ensure that each feature delivered is of the highest quality and conforms to BabyCenter engineering standards.</p>\n<p>Roles &amp; Responsibilities</p>\n<p>Lead and architect cloud solutions for scalable, highly available, secure web services and websites on AWS platform\nPlan and manage initiatives to migrate systems to AWS platform\nPartner with Engineering managers to build the technological vision, drives technology strategy and influences business partners and technology leaders on strategic direction\nDesign, implementation, and maintenance of new and existing features\nParticipate in defining and improving coding standards\nCollaborate with other software engineers to ensure that solutions are built in a consistent framework to a high-quality standard\nCollaborate with product, marketing, and sales teams to develop new products and features, gather requirements, and scope work\nMentor, coach, and support engineers in their technical growth and learning industry best practices\nRequirements</p>\n<p>8+ years web development experience, with 3+ years of experience as cloud solutions architect\nDeep understanding of frontend and backend web architecture and frameworks\nExpertise in services and tools on AWS platform, including Lambda, API gateway, SQS, SNS and S3, Kinesis, DynamoDB, Redshift\nHands on with Relational Database, NoSQL and Columnar Storage.\nProficient in modern web technologies including Java, Node.js and ReactJS\nExperience with designing and re-architecting application for cloud platforms running in AWS\nWorking knowledge of building RESTful web services in a service-oriented-architecture environment using cloud infrastructures\nAdept in computer science fundamentals, distributed processing, algorithms, problem solving, design patterns, and OO design\nExperience structuring the work of architectural efforts, entrust, guide and mentor other team members.\nExcellent verbal and written communication skills. Superior listening skills. Able to tailor your message to the audience and integrate feedback.\nDemonstrable ability to create clear, accessible, visual explanations of system architecture.\nQualifications</p>\n<p>Master of computer science degree or equivalent working experience\nLarge-scale consumer internet development experience</p>\n
                   """
    
    
    func convertHTML() -> NSAttributedString  {
        let data = Data(htmlText.utf8)
        if let attributedString = try? NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html], documentAttributes: nil) {
            descriptionTextView.attributedText = attributedString
            return attributedString
        }
        return descriptionTextView.attributedText
    }
    

    let descriptionTextView: UITextView = {
        let textView = UITextView()
        textView.font = .systemFont(ofSize: 14)
        textView.textAlignment = .left
        textView.isEditable = false
        return textView
    }()
    
    let applyButton: UIButton = {
       let button = UIButton(type: .system)
        button.backgroundColor = .systemBlue
        button.setTitle("Apply", for: .normal)
        button.tintColor = .white
        button.layer.cornerRadius = 15
        button.addTarget(self, action: #selector(handleApply), for: .touchUpInside)
        return button
    }()
    
    @objc func handleApply() {
        guard let url = URL(string: "https://boards.greenhouse.io/granular/jobs/1586132") else { return }
        let svc = SFSafariViewController(url: url)
        self.present(svc, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        descriptionTextView.attributedText = convertHTML()
        view.backgroundColor = .white
        view.addSubview(logoImageView)
        logoImageView.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: nil, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 10, left: 10, bottom: 0, right: 0), size: .init(width: 80, height: 100))
        
        
        let stackView = UIStackView(arrangedSubviews: [companyleLabel, titleLabel, urlButton, locationLabel
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
