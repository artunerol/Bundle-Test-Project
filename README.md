**Project Architecture:**
- App has been built with MVVM
- RxSwift was used & implemented using SPM
- Developer should inherit *BaseVC* for new created ViewControllers so that the application behaves same for every page.
- Loading spinner can be used for network requests. -> *Ex: class PackageListViewController L: 85*
- In order to create a new ViewController which uses *NavigationController*, developer should write a case for *NavigationEnum* and conform it.
- *NavigationRouter* has been implemented to adapt *BaseVC*
- Generic Native *NetworkLayer* was created to work with any kind of response data. -> Ex: *class NetworkLayer*
