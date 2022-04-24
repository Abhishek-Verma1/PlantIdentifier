# PlantIdentifier

## Introduction
The goal is to develop a small app capable of identifying plants through images.
The user submits the image using his camera or a photo from his library, the app will submit the image to plant.net API and display a list containing the results to the user.

 It has two screens:
 - Displays the user's camera to take a photo or select an image from his library.
 - Displays the plant results from plant.net. Tapping a row displays the image bigger, with the plant's name on top.

## How to use it
This application is build on on **Xcode 13.3.1** using swift 5.0. Minimum deployement target is 13.0 . It's advised to use the same configurations to run the app on device.

## Technical Details
This project is build using the Uncle [Uncle Bob's Clean architecture](https://blog.cleancoder.com/uncle-bob/2012/08/13/the-clean-architecture.html) . Project is divided into three main layers

- Domain : It's the buisness logic of the app and it's independent of other application's modules or technologies. 
- Data : It's the database layer of the app. It contains the storage of the app as well as the RepositryInterface implementations to talk to Domain.
- UI : It's the UI part of the application. I have used MVVM-C to implement it. 

MVVM is a design pattern that is widely used in the iOS application development. It take the data presentation and buisness logic of showing data to View out of ViewController making it clean, reuseable and small. ViewModel binds data to to UI elements and changes UI as soon as data changes. ViewController's responsibility is to notify ViewModel about the events that occur on the UI so ViewModel can react to those event accordingly.

Combining co-ordinator with it, further reduces ViewController's responsibilty by taking out the navigation logic from it too and making it completely dumb and reusable.

Benefts for this:
- Avoids Massive-ViewControllers
- Keep UI as dumb as possible
- Define single responsibility to each module
- Works best with reactive-frameworks


