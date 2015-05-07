//
//  SentMemeViewController.swift
//  mmTest
//
//  Created by William Song on 5/6/15.
//  Copyright (c) 2015 Bill Song. All rights reserved.
//

import UIKit

class SentMemeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var tableView: UITableView!
    var memes = [Meme]()
   
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidLoad()
        let applicationDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate)
        memes = applicationDelegate.memes
        if memes.count > 0 {
            
            super.viewDidAppear(true)
            println("You have \(memes.count) SentMemes in tableview")
            
        } else if self.memes.count == 0 {
            
            directToEditor()
        }
        
    }
    
    @IBAction func addMeme(sender: UIBarButtonItem) {
        directToEditor()
        println("You are sent to editor")
    }
    
    func directToEditor(){
        let storyboard = self.storyboard
        let vc = storyboard!.instantiateViewControllerWithIdentifier("MemeEditor") as! UIViewController
        self.presentViewController(vc, animated: true, completion: nil)
        println("You have \(memes.count), so goes to Editor")
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        let object = UIApplication.sharedApplication().delegate as! AppDelegate
        let appDelegate = object as AppDelegate
        memes = appDelegate.memes
        self.tableView.reloadData()
    }
    
     func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.memes.count;
    }
    
     func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("MemeCell", forIndexPath: indexPath) as! UITableViewCell
        let meme = memes[indexPath.row]
        
        // Set the image
        cell.imageView?.image = meme.memedImage
        cell.detailTextLabel?.text = meme.bottomText
       
        return cell
    }
     func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let detailController = self.storyboard!.instantiateViewControllerWithIdentifier("MemeDetails")! as! MemeDetailsViewController
        detailController.meme = self.memes[indexPath.row]
        self.navigationController!.pushViewController(detailController, animated: true)
    }
    
    
}

