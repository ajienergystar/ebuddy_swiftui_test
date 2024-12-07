//
//  UserViewModel.swift
//  EBuddyArtist
//
//  Created by mac on 6/12/24.
//

import SwiftUI
import FirebaseStorage
import FirebaseFirestore

class UserDetailsViewModel: ObservableObject {
    @Published var isLoading: Bool = false
    @Published var user: User? = nil
    @Published var errorMessage: String? = nil
    @Published var profileImage: UIImage? = nil

    private let storage = Storage.storage()

    func fetchUser(withId id: String) {
        isLoading = true
        let db = Firestore.firestore()

        db.collection("USERS").document(id).getDocument { [weak self] document, error in
            DispatchQueue.main.async {
                self?.isLoading = false
                if let error = error {
                    self?.errorMessage = error.localizedDescription
                    return
                }

                guard let data = document?.data() else {
                    self?.errorMessage = "User not found"
                    return
                }

                do {
                    var dataWithId = data
                    dataWithId["id"] = document?.documentID
                    let jsonData = try JSONSerialization.data(withJSONObject: dataWithId, options: [])
                    let user = try JSONDecoder().decode(User.self, from: jsonData)
                    self?.user = user
                    if let imageUrl = user.profileImageUrl {
                        self?.downloadProfileImage(from: imageUrl)
                    }
                } catch {
                    self?.errorMessage = "Failed to decode user data: \(error.localizedDescription)"
                }
            }
        }
    }

    func uploadProfileImage(_ image: UIImage, forUserId userId: String) {
        guard let imageData = image.jpegData(compressionQuality: 0.8) else { return }
        let storageRef = storage.reference().child("profile_images/\(userId).jpg")

        let uploadTask = storageRef.putData(imageData, metadata: nil)

        // Observe state changes for background uploading
        uploadTask.observe(.resume) { _ in
            print("Upload started.")
        }

        uploadTask.observe(.progress) { snapshot in
            let percentComplete = (100.0 * Double(snapshot.progress?.completedUnitCount ?? 0)) /
                Double(snapshot.progress?.totalUnitCount ?? 1)
            print("Upload is \(percentComplete)% complete.")
        }

        uploadTask.observe(.success) { [weak self] snapshot in
            print("Upload completed successfully.")
            storageRef.downloadURL { url, error in
                if let error = error {
                    self?.errorMessage = "Failed to retrieve image URL: \(error.localizedDescription)"
                    return
                }

                guard let url = url else { return }
                self?.updateProfileImageUrl(url.absoluteString, forUserId: userId)
            }
        }

        uploadTask.observe(.failure) { [weak self] snapshot in
            if let error = snapshot.error {
                self?.errorMessage = "Upload failed: \(error.localizedDescription)"
            }
        }
    }

    private func updateProfileImageUrl(_ url: String, forUserId userId: String) {
        let db = Firestore.firestore()
        db.collection("USERS").document(userId).updateData(["profile_image_url": url]) { [weak self] error in
            if let error = error {
                self?.errorMessage = "Failed to update Firestore: \(error.localizedDescription)"
                return
            }
            self?.fetchUser(withId: userId)
        }
    }

    private func downloadProfileImage(from url: String) {
        guard let imageUrl = URL(string: url) else { return }
        URLSession.shared.dataTask(with: imageUrl) { data, _, error in
            if let data = data, error == nil {
                DispatchQueue.main.async {
                    self.profileImage = UIImage(data: data)
                }
            }
        }.resume()
    }
}

