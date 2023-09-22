//
//  ViewController.swift
//  Astra
//
//  Created by Amit Shah on 22/09/23.
//

import UIKit

class ViewController: UIViewController{
    

    @IBOutlet weak var tableView: UITableView!
    var data = [ResponseData]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ApiHandler().request { hasData, data in
            if hasData, let ds = data{
                if let ds = try? JSONDecoder().decode(ResposneModel.self, from: ds){
                    self.data = ds.Search ?? []
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                        (self.view.viewWithTag(1) as? UILabel)?.isHidden = true
                    }
                }
            }else{
                (self.view.viewWithTag(1) as? UILabel)?.text = "failed to load data"
            }
        }
            
        tableView.delegate = self
        tableView.dataSource = self
    }

}


extension ViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as! TableViewCell
        cell.configure(with: self.data[indexPath.row])
        return cell
    }
}


class TableViewCell: UITableViewCell{
    
    @IBOutlet weak var banner: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var year: UILabel!
    
    func configure(with responseData: ResponseData) {
            title.text = responseData.Title ?? ""
            year.text = responseData.Year ?? ""
            banner.downloaded(from: responseData.Poster ?? "")
    }
}


extension UIImageView {
    func downloaded(from url: URL, contentMode mode: ContentMode = .scaleAspectFit) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() { [weak self] in
                self?.image = image
            }
        }.resume()
    }
    func downloaded(from link: String, contentMode mode: ContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        downloaded(from: url, contentMode: mode)
    }
}
