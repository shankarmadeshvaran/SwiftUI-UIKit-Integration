
import UIKit
import SwiftUI

class HomeViewController: UITableViewController {
    
    var pictures: [String] = ["https://cdn.pixabay.com/photo/2015/12/01/20/28/road-1072823_960_720.jpg",
        "https://image.shutterstock.com/image-photo/country-road-450w-628141070.jpg",
        "https://cdn.pixabay.com/photo/2013/11/28/10/36/road-220058_960_720.jpg",
        "https://cdn.pixabay.com/photo/2014/09/07/22/17/forest-438432_960_720.jpg",
        "https://cdn.pixabay.com/photo/2015/06/19/21/24/the-road-815297_960_720.jpg",
        "https://cdn.pixabay.com/photo/2015/12/01/20/28/green-1072828_960_720.jpg",
        "https://cdn.pixabay.com/photo/2015/12/01/20/28/fall-1072821_960_720.jpg",
        "https://images.pexels.com/photos/414612/pexels-photo-414612.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500",
        "https://images.pexels.com/photos/207962/pexels-photo-207962.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pictures.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = pictures[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if #available(iOS 13.0, *) {
            let pictureView = PictureView(imageURL: pictures[indexPath.row], receivedString: "SwiftUI")
            let hostVC = UIHostingController(rootView: pictureView)
            navigationController?.pushViewController(hostVC, animated: true)

        } else {
            if let vc = storyboard?.instantiateViewController(withIdentifier: "Picture") as? PictureViewController {
                vc.selectedImageURL = URL(string: pictures[indexPath.row])
                vc.receivedString = "UIKit"
                navigationController?.pushViewController(vc, animated: true)
            }
        }
    }
}

// To get Preview for HomeViewController
@available(iOS 13.0, *)
struct HomeViewControllerRepresentable: UIViewControllerRepresentable {

    func makeUIViewController(context: UIViewControllerRepresentableContext<HomeViewControllerRepresentable>) -> HomeViewController {
        return HomeViewController()
    }

    func updateUIViewController(_ uiViewController: HomeViewController, context: UIViewControllerRepresentableContext<HomeViewControllerRepresentable>) {
        // code to update your ViewController
    }
}

@available(iOS 13.0, *)
struct HomeViewControllerPreview: PreviewProvider {
    static var previews: HomeViewControllerRepresentable {
        HomeViewControllerRepresentable()
    }
}
