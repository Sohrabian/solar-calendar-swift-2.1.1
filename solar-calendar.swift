/** in Swift2.1.1 and XCode7.2 **/

import UNIKit
import Foundation



class ViewController: UIViewController {
    
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
	//call the solarcalendar method
        CalcSolarCalendar()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

   // calcSolarDate method 
   internal func CalcSolarCalendar(){
        
        var difference_between_days:Int = 0

        var strMonth = ""
        
        var date:Int = 0
        var month:Int = 0
        var year:Int = 0
        
	//get day , month and year from your divice
        let date_miladi = NSDate()
        let calendar = NSCalendar.currentCalendar()
        let components = calendar.components([.Day , .Month , .Year], fromDate : date_miladi)
        
        let year_miladi = components.year
        let month_miladi = components.month
        let day_miladi = components.day


        //date convert to string and send to the getDayOfWeek method
        let dateFormater = NSDateFormatter()
        dateFormater.dateFormat = "yyy-MM-dd"
        let dateString = dateFormater.stringFromDate(date_miladi)

        
        //day of month
        let not_leap_year = [0 , 31 , 59 , 90 , 120 , 151 , 181 , 212 , 243 , 273 , 304 , 334]
        let is_leap_year = [0 , 31 , 60 , 91 , 121 , 152 , 182 , 213 , 244 , 274 , 305 , 335]
        
        if ((year_miladi % 4 ) != 0) {
            date = not_leap_year[month_miladi - 1 ] + day_miladi
            
            if(date > 79){
                date = date - 79
                if(date <= 186){
                    switch (date % 31){
                    case 0:
                        month = date / 31
                        date = 31
                        break ;
                    default:
                        month = (date / 31) + 1
                        date = (date % 31)
                        break ;
                    }
                    year = year_miladi - 621 ;
                }else{
                    date = date - 186;
                    
                    switch(date % 30){
                    case 0 :
                        month = (date / 30 ) + 6
                        date = 30
                        break;
                    default:
                        month = (date / 30 ) + 7
                        date = (date % 30)
                        break;
                    }
                    year = year_miladi - 621
                }
            }else{
                if((year_miladi > 1996) && (year_miladi % 4) == 1 ){
                    difference_between_days = 11
                }else{
                    difference_between_days = 10
                }
                date = date + difference_between_days
                
                switch(date % 30){
                case 0 :
                    month = (date / 30) + 9
                    date = 30
                    break;
                default:
                    month = (date / 30) + 10
                    date = (date % 30)
                    break;
                }
                year = year_miladi - 622;
            }
        }else{
            date = is_leap_year[month_miladi - 1] + day_miladi
            
            if(year_miladi >= 1996){
                difference_between_days = 79
            }else{
                difference_between_days = 80
            }
            if(date > difference_between_days){
                date = date - difference_between_days
                
                if(date <= 186){
                    switch (date % 31) {
                    case 0 :
                        month = (date / 31)
                        date = 31
                        break;
                    default:
                        month = (date / 31) + 1
                        date = (date % 31)
                        break;
                    }
                    year = year_miladi - 621
                }else{
                    date = date - 186
                    
                    switch( date % 30){
                    case 0 :
                        month = (date / 30 ) + 6
                        date = 30
                        break;
                    default:
                        month = (date / 30 ) + 7
                        date = (date % 30 )
                        break;
                    }
                    year = year_miladi - 621
                }
            }else{
                date = date + 10
                
                switch (date % 30){
                case 0 :
                    month = (date / 30 ) + 9
                    date = 30
                    break;
                default:
                    month = (date / 30 ) + 10
                    date = (date % 30)
                    break;
                }
                year = year_miladi - 622;
            }
        }
        
        switch(month){
        case 1:
            strMonth = "فرودین"
            break;
        case 2:
            strMonth = "اردیبهشت"
            break;
        case 3:
            strMonth = "خرداد"
            break;
        case 4:
            strMonth = "تیر"
            break;
        case 5:
            strMonth = "مرداد"
            break;
        case 6:
            strMonth = "شهریور"
            break;
        case 7:
            strMonth = "مهر"
            break;
        case 8:
            strMonth = "آبان"
            break;
        case 9:
            strMonth = "آذر"
            break;
        case 10:
            strMonth = "دی"
            break;
        case 11:
            strMonth = "بهمن"
            break;
        case 12:
            strMonth = "اسفند"
            break;
        default:
            break;
        }
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.locale = NSLocale(localeIdentifier: "en_US")
        

	//casting int to string
        let int_year_solar:Int = year
        let String_year = String(int_year_solar)
        
	//Converting to Solar date extention (YYY/MM/DD) 
        let format_month = String(format:"%02d" , month)
        let format_date = String(format: "%02d" , date)
        
        
        print("date Solar is : " + String_year + "/" +  format_month + "/" + format_date)
        print("Month is : " + strMonth)


        // date string sened to DayOfWeek Method
        getDayOfWeek(dateString)       

    }


    // getDayOfWeek method
    func getDayOfWeek (today:String) {
        
        
        let formatter = NSDateFormatter()
        formatter.dateFormat = "yyy-MM-dd"

        if let todayDate = formatter.dateFromString(today){

            let myCalendar = NSCalendar(calendarIdentifier: "gregorian")
            let myComponents = myCalendar?.components(.Weekday, fromDate: todayDate)
            let weekDay = myComponents?.weekday
            
            let weekDay_solar = ["شنبه" , "یکشنبه" , "‍ دو شنبه" , "سه شنبه" , "چهارشنبه" , "پنج شنبه" , "جمعه"]
            
            if(weekDay != 7){
                for var i=0 ; i <= weekDay_solar.count ; i++ {
                    if(weekDay == i){
                        print("day is : " + weekDay_solar[i])
                    }
                }
            }else{
                print("day is : " + weekDay_solar[0])
            }
        }
    }

    
}

        /*
        output is : 
                     date solar is : 1395/07/02
                     month is : مهر
                     day is : جمعه
        */