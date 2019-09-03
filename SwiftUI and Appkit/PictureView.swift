
import SwiftUI
import Combine

@available(iOS 13.0, *)
struct PictureView : View {

    let imageURL: String?
    let receivedString: String?

    var body: some View {
        NavigationView {
            ImageViewContainer(imageURL: imageURL ?? "")
        }.navigationBarTitle(Text(receivedString ?? ""), displayMode: .inline)
    }
}

@available(iOS 13.0, *)
struct ImageViewContainer: View {
    @ObservedObject var remoteImageURL: RemoteImageURL

    init(imageURL: String) {
        remoteImageURL = RemoteImageURL(imageURL: imageURL)
    }

    var body: some View {
        Image(uiImage: (remoteImageURL.data.isEmpty) ? UIImage(imageLiteralResourceName: "Swift") : UIImage(data: remoteImageURL.data)!)
            .resizable()
            .aspectRatio(contentMode: .fit)
    }
}

@available(iOS 13.0, *)
class RemoteImageURL: ObservableObject {
    var didChange = PassthroughSubject<Data, Never>()
    
    @Published var data = Data() {
        didSet {
            update()
        }
    }
    
    func update() {
        didChange.send(data)
    }
    
    init(imageURL: String) {
        guard let url = URL(string: imageURL) else { return }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else { return }
            
            DispatchQueue.main.async {
                self.data = data
            }
            
        }.resume()
    }
}
