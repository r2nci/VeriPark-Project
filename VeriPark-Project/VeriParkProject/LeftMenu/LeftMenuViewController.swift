//
//  LeftMenuViewController.swift
//  VeriParkProject
//
//  Created by Ramazan ikinci on 9.12.2021.
//

import UIKit

class LeftMenuViewController: UIViewController {
    
    var source = ["Hisse ve Endesler","Yükselenler","Düşenler","Hacme göre -30","Hacme göre -50","Hacme göre -100"]
    weak var vcA: ListViewController?
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.register(UINib(nibName: "LeftMenuTableViewCell", bundle: nil), forCellReuseIdentifier: "LeftMenuTableViewCell")
            tableView.delegate = self
            tableView.dataSource = self
            tableView.backgroundColor = .clear
            tableView.separatorColor = .none
        }
    }
    
    @IBOutlet weak var viewContent: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

}

extension LeftMenuViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return source.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "LeftMenuTableViewCell", for: indexPath) as? LeftMenuTableViewCell else { return UITableViewCell() }
        
        cell.labelTitle.text = source[indexPath.row]
        return cell
    }
    
    
}
