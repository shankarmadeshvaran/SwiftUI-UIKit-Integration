
import UIKit
import SwiftUI

class PictureViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    var selectedImageURL: URL?
    var receivedString: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = receivedString
        guard let imageURL = selectedImageURL else { return }
        imageView.loadImage(from: imageURL)
    }
}

extension UIImageView {
    func loadImage(from url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}

// To get Preview for PictureViewController
@available(iOS 13.0, *)
struct PictureViewControllerRepresentable: UIViewControllerRepresentable {

    func makeUIViewController(context: UIViewControllerRepresentableContext<PictureViewControllerRepresentable>) -> PictureViewController {
        return PictureViewController()
    }

    func updateUIViewController(_ uiViewController: PictureViewController, context: UIViewControllerRepresentableContext<PictureViewControllerRepresentable>) {
        // code to update your ViewController
        //use static ImageUrl to display image in previews
    }
}

@available(iOS 13.0, *)
struct PictureViewControllerPreview: PreviewProvider {
    static var previews: PictureViewControllerRepresentable {
        PictureViewControllerRepresentable()
    }
}
