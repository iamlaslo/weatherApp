# weatherApp

Technologies which I used in this app and learned how to work with them:
- Xcode
- Swift
- Git and GitHub
- UIKit
- CocoaPods
- Alamofire
- ObjectMapper
- Realm
- Delegates and DataSources
- Segues
- Auto Layout 
- Constraints
- Stack views
- UserDefaults
- UICollectionView
- UIPickerView
- UIGestureRecognizer
- LocationManager
- Open Weather OneCall API
- Swift Dates
- DateFormatter
- Alerts
- Singleton pattern
- Localization
- Custom fonts

Description of the applications’ algorithm:
When user is using this app in the first time, the first thing which he would see is an alert which asks about location sharing. If user gives the permission to use his location, app creates an instance of LocationManager, gets the user’s location and pass data next to the NetworkManager which based on Alamofire. It creates a GET request to the OpenWeatherMap API with parameters of user’s longitude and latitude, default language of user’s device and default unit system (Metric). Response of this operation transfers to the function’s escaping callback, which is passing back to the NetworkManager, where it writes to the Realm’s model via WriteModel method of the RealmManager class, and then it’s passing to the updateUI function, which starts working in the main async queue. This transfer between queues helps to avoid the delay in the app’s interface creating and response to the user’s actions. After this operations data from the API request comes to all the labels and images in the View and UICollectionView’s DataSource. 

After the creating of UI, user have next options:
- Check the current weather on the MainView
- Check the weather on every of the next 7 days thanks to Collection View, which cells opens the DetailView of the chosen day
- Change units and language in the SettingsView, which works thanks to UserDefaults. This action requires the restart of the app: I found no way to change the language of the app without restart

In the process of creating this app I stumbled upon a bug: UICollectionView has created cells, but I couldn’t see it. Later all my Views became black, and after that I couldn’t even select any item. I tried to ‘fight’ with it for literally 2 hours, but thanks to GitHub: I just returned to backup, which I made the night before.

Every topic and technology listed above were learned and used by me by the next resources: SwiftBook, official Swift documentation, raywenderlich.com, Sean Allen’s YouTube channel, The Swift Developers Youtube channel. iOS academy, Alamofire documentation, Realm documentation, Medium.com with membership, Hacking with Swift, habr.com.
And the main one: KeepSolid internship, where I learned to implement all of this with the help of my mentor Alex.
