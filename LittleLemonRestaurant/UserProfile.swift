//
//  UserProfile.swift
//  LittleLemonRestaurant
//
//  Created by Guild Junior on 24/05/23.
//

import SwiftUI

struct SubscribeItem: Identifiable, Codable {
    var id = UUID()
    let name: String
    var isSelected: Bool
}

struct UserProfile: View {
    @Environment(\.presentationMode) var presentation // required to dismiss from this view to main navigation view
    
    @State private var firstNameLabel = UserDefaults.standard.string(forKey: keyFirstName) ?? ""
    @State private var lastNameLabel = UserDefaults.standard.string(forKey: keyLastName) ?? ""
    @State private var emailLabel = UserDefaults.standard.string(forKey: keyEmail) ?? ""
    
    @State private var isLoggedIn = true
    @State private var isSaved = false
    
    @State private var userForm = UserForm()
    
    @State private var subscriptions = [SubscribeItem(name: "Order statutes", isSelected: true),
                                        SubscribeItem(name: "Password changes", isSelected: true),
                                        SubscribeItem(name: "Special offers", isSelected: true),
                                        SubscribeItem(name: "Newsletter", isSelected: true)]
    
    var body: some View {
        VStack(spacing: 20) {
            
            Header()
            
            avatarSection
            
            styledTextFieldSection
            
            emailNotifications
            
            logoutButton
            
            discardChangesButtonAndSaveChangesButton
        }
        .padding()
        .alert("ERROR !", isPresented: $userForm.showInvalidMessage) {
            Button("OK", role: .cancel) { }
        } message: {
            Text(userForm.errorMessage)
        }
    }
    
    // avatar layer
    private var avatarSection: some View {
        VStack {
            Text("Personal Information")
                .font(.custom("Karla-Bold", size: 20))
                .foregroundColor(Color("highlightTwo"))
            
            HStack(spacing: 20) {
                VStack(alignment: .leading, spacing: 0) {
                    Text("Avatar")
                        .font(.custom("Karla-Regular", size: 16))
                        .foregroundColor(Color.gray)
                    Image("profile-image-placeholder")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 100, height: 100)
                        .clipShape(Circle())
                }
                // avatar buttons
                Button("Change") { }
                    .buttonStyleThree()
                
                Button("Remove") { }
                    .buttonStyleFour()
                
                Spacer()
            }
        }
    }
    
    @ViewBuilder
    private var styledTextFieldSection: some View {
        TextField(firstNameLabel, text: $userForm.firstName)
            .styledTextField(with: "First Name")
        
        TextField(lastNameLabel, text: $userForm.lastName)
            .styledTextField(with: "Last Name")
        
        TextField(emailLabel, text: $userForm.email)
            .styledTextField(with: "Email")
            .keyboardType(.emailAddress)
            .textContentType(.emailAddress)
            .autocapitalization(.none)
    }
    
    private var emailNotifications: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text("Email notifications")
                .font(.custom("Karla-Bold", size: 16))
                .foregroundColor(Color("highlightTwo"))
                .frame(width: 150, height: 20)
            
            ForEach($subscriptions) { $notification in
                HStack {
                    Image(systemName: notification.isSelected ? "checkmark.square.fill" : "square")
                        .foregroundColor(notification.isSelected  ? Color("primaryOne") : Color.black)
                    Text(notification.name)
                }
                .onTapGesture {
                    withAnimation(.easeInOut(duration: 0.7)) {
                        notification.isSelected.toggle()
                    }
                }
            }
        }
        .font(.custom("Karla-Regular", size: 13))
        .padding(.trailing, 220)
    }
    
    // logout button
    private var logoutButton: some View {
        Button("Log out") {
            UserDefaults.standard.set("", forKey: keyFirstName)
            UserDefaults.standard.set("", forKey: keyLastName)
            UserDefaults.standard.set("", forKey: keyEmail)
            
            $subscriptions.forEach { $item in
                item.isSelected = false
            }
            UserDefaults.standard.set(try? JSONEncoder().encode(subscriptions), forKey: keyNotificationSaved)
            
            UserDefaults.standard.set(false, forKey: keyIsLoggedIn)
            isLoggedIn = false
            self.presentation.wrappedValue.dismiss() // dismiss from this view to main navigation view
        }
        .buttonStyleFive()
    }
    
    private var discardChangesButtonAndSaveChangesButton: some View {
        HStack(spacing: 30) {
            Spacer()
            // Discard button
            Button("Discard changes") {
                userForm.firstName = ""; userForm.lastName = ""; userForm.email = ""
                $subscriptions.forEach { $item in
                    item.isSelected = false
                }
            }
            .buttonStyleTwo()

            Button("Save changes") {
                userForm.validateUserForm()
                if userForm.isUserFormValid {
                    isSaved = true
                    userForm.isUserFormValid = false
                }

                UserDefaults.standard.set(try? JSONEncoder().encode(subscriptions), forKey: keyNotificationSaved)
//                print("saved susbscriptions \(subscriptions)")
            }
            .buttonStyleOne()
            .alert("NOTIFICATION !", isPresented: $isSaved) {
                Button("OK", role: .cancel) { isSaved = false }
            } message: {
                Text("Personal information has changed.")
            }

            .onAppear {
                if let data = UserDefaults.standard.value(forKey: keyNotificationSaved) as? Data {
                    subscriptions = try! JSONDecoder().decode(Array<SubscribeItem>.self, from: data)
//                    print(subscriptions)
                }
            }

            Spacer()
        }
    }
}

struct UserProfile_Previews: PreviewProvider {
    static var previews: some View {
        UserProfile()
    }
}
