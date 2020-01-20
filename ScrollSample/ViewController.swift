//
//  ViewController.swift
//  ScrollSample
//
//  Created by hara on 2020/01/20.
//  Copyright © 2020 hara. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!

    var num: Int = 5
    
    // addCellsメソッドの実行回数をカウントするための変数
    var executionsCount: Int = 0
    
    var addCount: Int = 0
    
    var isFetching: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func addCells() {
        executionsCount += 1
        print("addCellsメソッドを実行しました。 \(executionsCount)回目")
        
        if isFetching { return }
        
        isFetching = true

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.num += 10
            self.tableView.reloadData()
            self.isFetching = false
            
            self.addCount += 1
            print("実際にデータを追加した回数 \(self.addCount)回")
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return num
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel!.text = "\(indexPath.row)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let currentOffsetY: CGFloat = scrollView.contentOffset.y
        let maximumOffset: CGFloat = scrollView.contentSize.height - scrollView.frame.height
        let distanceToBottom: CGFloat = maximumOffset - currentOffsetY
        
        if !tableView.isTracking {
            if distanceToBottom < 1000 {
                addCells()
            }
        }
    }
}
