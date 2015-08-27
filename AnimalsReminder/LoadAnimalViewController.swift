//
//  LoadAnimalViewController.swift
//  AnimalsReminder
//
//  Created by Mélissa Grach on 24/08/2015.
//  Copyright (c) 2015 Mélissa Grach. All rights reserved.
//

import UIKit
import CoreData

class LoadAnimalViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource{
    

    @IBOutlet weak var animalNameLabel: UILabel!
    @IBOutlet weak var animalAgeLabel: UILabel!
    @IBOutlet weak var animalTypeLabel: UILabel!
    @IBOutlet weak var updateAnimalBtn: UIButton!
    @IBOutlet weak var updateNameLabel: UITextField!
    @IBOutlet weak var validateUpdate: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateNameLabel.alpha = 0
        validateUpdate.hidden = true
        //saveInformation
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    var intRes = 0
    
        //useLoadInPickerView
        func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
            return 1
        }
        
        func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
            var appDel:AppDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate)
            var context:NSManagedObjectContext = appDel.managedObjectContext!
            
            var request = NSFetchRequest(entityName: "Animals")
            
            var results:NSArray = context.executeFetchRequest(request, error: nil)!
            
            return results.count
       }
        
        func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
            var res = "No animal yet"
            var appDel:AppDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate)
            var context:NSManagedObjectContext = appDel.managedObjectContext!
            
            var request = NSFetchRequest(entityName: "Animals")
            
            var results:NSArray = context.executeFetchRequest(request, error: nil)!

            if (results.count > 0){
                return results[row].valueForKey("name") as! String
            }else{
                return res
                }
        }
        
        func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
            var appDel:AppDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate)
            var context:NSManagedObjectContext = appDel.managedObjectContext!
            
            var request = NSFetchRequest(entityName: "Animals")
            
            var results:NSArray = context.executeFetchRequest(request, error: nil)!
            var name = results[row].name
            animalNameLabel.text = results[row].name
            animalTypeLabel.text = results[row].type
            intRes = row;
            
            //UpdateBtn
            updateAnimalBtn.setTitle("Modify" , forState: .Normal)
            validateUpdate.hidden = false
        }
    
    @IBAction func UpdateOnClic(sender: AnyObject) {
        updateNameLabel.alpha = 1
        
        println("update ask")
    }

    @IBAction func UpdateDone(sender: AnyObject) {
        var appDel:AppDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate)
        var context:NSManagedObjectContext = appDel.managedObjectContext!
        
        var request = NSFetchRequest(entityName: "Animals")
        
        var results:NSArray = context.executeFetchRequest(request, error: nil)!
        var newName = updateNameLabel.text
        println(updateNameLabel.text)
        
       /* var object:NSManagedObject = NSEntityDescription.insertNewObjectForEntityForName("Animals", inManagedObjectContext: context) as! NSManagedObject
        object.setValue(newName, forKey: object[intRes].name)
        context.save(nil)*/
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
}
