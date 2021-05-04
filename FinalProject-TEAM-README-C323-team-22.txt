C323 / Spring 2021 Final Project

Serena Press - sapress@iu.edu
Sai Jannali - sjannali@iu.edu
Aidan Lesh - ailesh@iu.edu

How to interact with our app:
Begin on the 'Choose Photo' tab of the application.
click either the 'choose photo from gallery' button to choose a photo to edit from your camera roll
or the 'take photo with camera' button to take a new photo to edit.

Then, once your photo has loaded onto the screen, go to the next tab ('edit')
Here, you may edit your photo by clicking one of the three buttons ('hue', 'brightness', and 'contrast')
and sliding the subsequent slider that loads onto the screen to adjust each property on a scale.
Once you've finished adjusting a property, click the 'back' button to return to the main editing screen.

Once you are satisfied with your edited photo, select the 'save' button.

From there, your photo is now saved in your camera roll and the 'view all' tab.
To view all of your previously edited photos from alter color, click the 'view all' tab
where you can look at everything in a table view.
You can also find your edited photo in your camera roll.

To edit further, choose a new photo from the camera roll by returning to the 'choose photo' tab 
and either choosing a new photo or one that you previously edited and saved.


Xcode & Devices used:
Xcode environment - Xcode 12.4
Device - iPhone SE 2nd generation


Required features:
1. We used the MVC pattern 

2. Our user interface incorporates 
	input: slider, buttons
	output: image, table view, buttons
	Three views: TabViewController, PickPhotoViewController, EditPhotoViewController, ViewAllTableViewController
	TableViewController: ViewAllTableViewController

3. We have not created a photo editing app in class, we don't have a server side connection, or any 
	non internet based services
	We did not incorporate loading previous editing states from the 'view all' view

4. We have input of images (loaded in to edit) and user input of sliding the sliders to edit
	We have output of the image saved
	Our UI is the three views encapsulated in the tab view controller
	
	We have persistent local data storage - this includes the file path to the image and the data about the 
	image (incl. date)
	
5. We made substantial use of the UIImagePickerController as seen on the 'choose photo' tab.
	The user can pick a photo from their camera roll or by taking a new photo with their camera.
	
6. We made substantial use of the Accelerate framework as seen on the 'edit' tab.
	The user can edit their image using this framework including the photo's hue, brightness, and contrast.
	

Changes made from assignment 01:
We did not make any design or functionality changes from our plan in assignment 01.


Noteworthy - the use of accelerate in the edit tab







