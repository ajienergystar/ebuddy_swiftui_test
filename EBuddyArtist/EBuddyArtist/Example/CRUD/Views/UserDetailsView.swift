import SwiftUI

struct UserDetailsView: View {
    @StateObject private var viewModel = UserDetailsViewModel()
    @State private var isImagePickerPresented = false
    @State private var selectedImage: UIImage?
    
    var body: some View {
        NavigationView {
            VStack(spacing: 16) {
                if viewModel.isLoading {
                    ProgressView("Loading user data...")
                } else if let user = viewModel.user {
                    if let profileImage = viewModel.profileImage {
                        Image(uiImage: profileImage)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 150, height: 150)
                            .clipShape(Circle())
                            .shadow(radius: 5)
                    } else {
                        Circle()
                            .fill(Color.gray.opacity(0.5))
                            .frame(width: 150, height: 150)
                            .overlay(Text("No Image").foregroundColor(.white))
                    }
                    
                    Button(action: {
                        isImagePickerPresented = true
                    }) {
                        Text("Upload Profile Image")
                            .font(.headline)
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                    
                    Form {
                        Section(header: Text("User Details")) {
                            TextRow(label: "UID", value: user.uid)
                            TextRow(label: "Email", value: user.email)
                            TextRow(label: "Phone Number", value: user.phoneNumber)
                            TextRow(label: "Gender", value: user.gender.capitalized)
                        }
                    }
                } else if let errorMessage = viewModel.errorMessage {
                    Text("Error: \(errorMessage)")
                        .foregroundColor(.red)
                        .multilineTextAlignment(.center)
                }
            }
            .padding()
            .onAppear {
                viewModel.fetchUser(withId: "NrnUnKQxLz6P8pyQpsx7")
            }
            .sheet(isPresented: $isImagePickerPresented) {
                ImagePicker(image: $selectedImage, onImagePicked: { image in
                    if let image = image {
                        viewModel.uploadProfileImage(image, forUserId: "NrnUnKQxLz6P8pyQpsx7")
                    }
                })
            }
        }
    }
}

struct TextRow: View {
    let label: String
    let value: String
    
    var body: some View {
        HStack {
            Text(label)
                .font(.headline)
                .foregroundColor(.primary)
            Spacer()
            Text(value)
                .font(.body)
                .foregroundColor(.secondary)
        }
    }
}
