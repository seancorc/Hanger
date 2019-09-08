<img src="https://github.com/seancorc/Hanger/blob/master/home.gif" width="250">


## Documentation

### Current Toolkit:
**Language:** Swift 5.0  
**Architectural Pattern:** MVC  
**Pods:**  
1. SnapKit - Simpler Autolayout
2. Koloda - For Swipe Left/Right Functionality
3. Alamofire - For making network requests and handling responses
4. Promises - For elegant handling of asynchronous code (mainly used in networking layer)
5. YPIImagePicker - Easy to use image picker
6. Kingfisher - For caching profile picture so that a network request does not have to always be made

### Data Management & Networking:  
**Networking Layer:** 
I have split the networking layer into three parts: 1. Request creation, 2. Request execution, 3. Operations.  
This separation of concerns paired with the Promises pod allows network requests to be made and handled effortlessly.  
Example Use: 
```Swift
let loginTask = LoginTask(email: email, password: password)
        loginTask.execute(in: self.networkManager).then { (user) in
            //Handle response
            }.catch { (error) in
            //Handle error
        }
``` 
** Persistence:** 
1. UserDefaults: UserDefaults is used to store small bits of information, such as if a user is logged in.
2. Keychain: Keychain will be used to store more sensitive information, such as web tokens.
3. SQLite: SQLite will be used to persist message data.
