//
//  AnimalViewController.swift
//  AnimalsReminder
//
//  Created by Mélissa Grach on 24/08/2015.
//  Copyright (c) 2015 Mélissa Grach. All rights reserved.
//

import UIKit
import CoreData

class AnimalViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var animalName: UITextField!
    @IBOutlet weak var animalMonth: UITextField!
    @IBOutlet weak var animalDay: UITextField!
    @IBOutlet weak var animalYear: UITextField!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //pickerView
    var  animalTypes = ["Cat", "Dog", "Horse", "Ferret", "NAC Other"]
    var  typeChosen = "default"
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return animalTypes.count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        return animalTypes[row]
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        typeChosen = animalTypes[row]
    }
    
    //SaveBtn
    @IBAction func SaveAnimalBtn(sender: AnyObject) {
        if (animalName.text.isEmpty || animalDay.text.isEmpty || animalMonth.text.isEmpty ||
            animalYear.text.isEmpty){
                
                var alert = UIAlertController(title: "Alert", message: "Informations Missing", preferredStyle: UIAlertControllerStyle.Alert)
                alert.addAction(UIAlertAction(title: "Click", style: UIAlertActionStyle.Default, handler: nil))
                self.presentViewController(alert, animated: true, completion: nil)

        }else{
            //Add Birthday
            var dateComponents = NSDateComponents()
            dateComponents.day = animalDay.text.toInt()!
            dateComponents.month = animalMonth.text.toInt()!
            dateComponents.year = animalYear.text.toInt()!
            
            var calendar = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)!
            var birthdate = calendar.dateFromComponents(dateComponents)
            var currentDate = NSDate()
            
            var getAge = calendar.components(NSCalendarUnit.CalendarUnitYear, fromDate: birthdate!, toDate: currentDate, options: nil)
            var age = getAge.year
            var type = typeChosen
            
            //saveInformation
            var appDel: AppDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate)
            var context:NSManagedObjectContext = appDel.managedObjectContext!
            
            var newAnimal = NSEntityDescription.insertNewObjectForEntityForName("Animals",
                inManagedObjectContext: context) as! NSManagedObject
            newAnimal.setValue(animalName.text, forKey: "name")
            newAnimal.setValue(age, forKey: "age")
            newAnimal.setValue(typeChosen, forKey: "type")
            
            context.save(nil)
        }
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
