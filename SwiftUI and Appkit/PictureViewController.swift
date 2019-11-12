
import UIKit

#if canImport(SwiftUI) && DEBUG
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

struct PictureViewRepresentable: UIViewRepresentable {
    func makeUIView(context: Context) -> UIView {
        return UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "Picture").view
    }
    
    func updateUIView(_ view: UIView, context: Context) {
        //update your code here
    }
}

@available(iOS 13.0, *)
struct PictureViewController_Preview: PreviewProvider {
    static var previews: some View {
        PictureViewRepresentable()
    }
}
#endif
