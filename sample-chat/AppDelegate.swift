
import CoreData
import RxSwift
import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    // MARK PUBLIC

    var window: UIWindow?

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.setupApplication()
        self.window!.backgroundColor = UIColor.white
        self.window!.makeKeyAndVisible()

        return true
    }

    // MARK PRIVATE

    private var chatVC: ChatVC!
    private var chat: Chat!
    private var sendView: SendView!
    
    private let disposeBag = DisposeBag()

    func setupApplication() {
        // Load SendView.
        self.sendView =
            Bundle.main.loadNibNamed(
                "SendView",
                owner: nil,
                options: nil)?.first as! SendView

        // ViewModel.
        self.chat = Chat()

        // View.
        self.chatVC = ChatVC()
        self.window!.rootViewController = self.chatVC

        // Provide send view to chat VC.
        self.chatVC.sendView = self.sendView

        // Sync view and viewmodel.
        self.chat.messages
            .asObservable()
            .bind(to: self.chatVC.messages)
            .disposed(by: self.disposeBag)

        // Add SendView message as 'Human' author.
        self.sendView.lastMessage
            .asObservable()
            .filter { $0.characters.count > 0 }
            .subscribe(onNext: { [unowned self] text in
                var msg = ChatMessage()
                msg.author = "Human"
                msg.text = text
                NSLog("AppDelegate. SendView last msg: '\(msg)'")
                self.chat.addMessage(msg)
            })
            .disposed(by: self.disposeBag)
    }

    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "sample_chat")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

}

