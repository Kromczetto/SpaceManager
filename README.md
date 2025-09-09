# Space Manager

A mobile application for creating, managing, and scanning objects using QR codes. Data is stored in Firebase, and the application includes a role-based access system for users.

---

## Features

- Create two types of objects:
  - Static objects – properties do not change over time.
  - Active objects – properties can change dynamically.
- Fully customizable properties – each object can have its own unique set of attributes. Properties can also be reused.
- Templates – quickly assign predefined sets of properties to multiple objects.
- Generate and scan QR codes – QR codes serve as identifiers for objects. After scanning, the object data is retrieved from Firebase.
- Firebase integration:
  - Authentication for user accounts.
  - Database for storing objects and user data.
- Role-based access:
  - Viewer – can only read objects.
  - Editor – can read and add objects, and modify or delete them.
  - Administrator – has full control, including managing users and their objects.
- Object management:
  - Edit object properties after scanning QR codes.
  - Permanently delete objects when needed.

---

## Technologies

- Swift and SwiftUI for the mobile application.
- Firebase Authentication for user accounts.
- Firebase Firestore for object and user data.
- QR code generator and scanner.

---

## User Roles

- Viewer: can read objects only.  
- Editor: can read, add, edit, and delete objects.  
- Administrator: full access, including user management and object removal.  

---

## How to Use

1. Register or log in to create a user account.
2. Create an object:
   - Choose static or active type.
   - Add custom properties or apply a template.
   - Generate a QR code for the object.
3. Read an object:
   - Scan its QR code.
   - View its properties stored in Firebase.
4. Manage objects:
   - Edit properties of active objects.
   - Delete objects permanently if they are no longer needed.
5. Administration (administrator only):
   - View all users.
   - Remove users and their objects.

---

## Example Use Cases

- Resource management in companies (e.g., equipment tracking).  
- Inventory management in warehouses.  
- Labeling items with dynamic properties (e.g., devices with technical parameters).  
- QR-based cataloging and identification systems.  

---

## Future Development

- Offline mode with data synchronization when reconnected to the internet.  
- Support for additional identification formats such as NFC or RFID.  
- Extended reports and statistics for administrators. 

---

This project was created to develop programming skills using Swift and SwiftUI with Firebase.
