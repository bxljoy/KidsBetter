//
//  TaskDiffableDataSource.swift
//  KidsBetter
//
//  Created by bxl on 2021/12/19.
//

import UIKit

enum Section {
    case date
    case taskItem
}

class TaskDiffableDataSource: UITableViewDiffableDataSource<Section, Task> {

    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
}
