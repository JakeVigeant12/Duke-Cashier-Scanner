#  Duke Cashier Scanner Project
This SwiftUI application was developed to streamline document entry procedures for cashiers at all 50 of Duke's retail/dining/service locations daily. Previous solutions failed to provide a clean., intuitive interface to scan, collect, and mark all relevant documents and email them to the finance office. The application generates and emails PDF of all relevant document scans, coupled with pre-populated account and cash register location information to save time. 

## Note - Add User Information on the Profile Page First to See All Functionality 
## Demo - https://www.youtube.com/watch?v=5iO2yDALrhE
## 1. Main Menu
    1.1 Displayed when the app is opened, corresponding to three different pages.
    1.2 The **User Information** button leads to the **User Profile** page for editing default work information. This information must be entered the first time the app is launched and is then saved in the sandbox and loaded automatically.
    1.3 The **Virtual Deposit Bag** button directs to the **Deposit Bag Edit** page, where previously filled User Information is auto-filled as default (if available, otherwise blank).
    1.4 The **View Messages** button navigates to the **Message Box** page, displaying communication messages from the server program. This button also shows the count of received but unresolved events.

## 2. User Profile Page
    2.1 The department picker options are read from a JSON file, and retail location picker options correspond to the selected department. Selecting **Other** adds a text field for manual input.
    2.2 After completion, pressing the **Save** button saves the data to the model and sandbox, whereas **Clear** only empties the text fields without saving.
    2.3 Editing user information is possible while editing the Virtual Deposit Bag. Changes to Name, DUID, Phone, and Email apply immediately to the current Deposit Bag. However, changes to Department, Location, and POS do not, and can be applied by returning to the **Deposit Bag Edit** page and pressing the **Set As Default** button.

## 3. Deposit Bag Info Page
    3.1 Users need to confirm the deposit bag's department, retail location, POS, and choose a date (defaulting to today). Pressing **Set As Default** resets the current Department, Location, POS to the saved user defaults, and the date to the current date.
    3.2 If opting to send a cash deposit to University Cashiering, a prompt for barcode scanning appears. Scanning is initiated by pressing the blue button. On scan failure or if sending is not needed, the barcode number will read “No Bag Number”. Users can press **Back** to edit or scan again, or confirm information and press **Next**.
    3.3 In the file scanning page, pressing the **plus button** next to the desired file type opens options to choose from the Photo Library or use the Camera for scanning. Photo Library allows multiple selections, whereas Camera scanning offers more post-processing options. Each image type list is scrollable, and tapping any image enables full-screen viewing (with swipe navigation) and deletion decisions.
    3.4 After completing all file scans, the final information preview page shows all details of the deposit bag, including the scanned file type list. This information also appears on the first page of the final PDF file. Pressing **Preview** allows PDF file preview based on current information. Correct files can be saved using the **Save** button. After Save, users can cancel or edit information by pressing **Back** button in the upper left corner. **Submit** button generates an email with user information and the PDF attachment, requiring only a send button press to complete.

## 4. View Messages Button
    Manually refresh messages by clicking the refresh button on the right. Swipe left on any message to mark it as completed and delete it.

## 5. Admin Panel
    Access to the admin panel to send messages to cashiers using the app (by DUID) is here:
    https://edeposit-backend-aa3d55395f8f.herokuapp.com/
