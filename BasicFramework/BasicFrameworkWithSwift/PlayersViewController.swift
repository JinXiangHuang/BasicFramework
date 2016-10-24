//
//  PlayersViewController.swift
//  BasicFramework
//
//  Created by mr-tech on 16/9/23.
//  Copyright © 2016年 Rainy. All rights reserved.
//

import UIKit


class PlayersViewController: UITableViewController {

    var Players:[Player] = [ Player(name:"Bill Evans", game:"Tic-Tac-Toe", rating: 4),
                             Player(name: "Oscar Peterson", game: "Spin the Bottle", rating: 5),
                             Player(name: "Dave Brubeck", game: "Texas Hold 'em Poker", rating: 2) ]
    

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
       
        return 1
    }

    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        if indexPath.row == 1 {
            return 79;
        }
        return 44;
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      
        return Players.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let player = Players[indexPath.row] as Player
        
        if indexPath.row == 2 {
            
            let cell = tableView.dequeueReusableCellWithIdentifier("playercell2", forIndexPath: indexPath)
                as UITableViewCell
            
            cell.textLabel?.text = player.name
            
            return cell
        } else if indexPath.row == 1{
            
           if let cell = tableView.dequeueReusableCellWithIdentifier("playercell1", forIndexPath: indexPath)
            as? PlayersCell {
            
            cell.nameCode.text = player.name
            cell.gameCode.text = player.game
            return cell
            
            }

//            let nameLabel = cell.viewWithTag(100) as! UILabel
//             nameLabel.text = player.name
//            
//            if let nameLabel = cell.viewWithTag(100) as? UILabel {
//                nameLabel.text = player.name
//            }
//            if let gameLabel = cell.viewWithTag(101) as? UILabel {
//                gameLabel.text = player.game
//            }
            
          
        }
        
        let cell = tableView.dequeueReusableCellWithIdentifier("playercell", forIndexPath: indexPath)
            as UITableViewCell
        
        cell.textLabel?.text = player.name
        
        cell.detailTextLabel?.text = player.game
        
        return cell
        //使用表项的子类  在项目中以Cocoa Touch Class模板添加一个新文件，命名为PlayerCell并令其继承UITableViewCell。不要选中创建XIB的选项，因为Storyboard里已经有表项了。
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
