# Herocam Service ![swift 3](https://camo.githubusercontent.com/93de6573350b91e48ab570a4fe710e4e8baa38b8/687474703a2f2f696d672e736869656c64732e696f2f62616467652f73776966742d332e302d627269676874677265656e2e737667)

A basic Swift/Vapor webservice that is used by the [HeroCam app](https://herocamapp.github.io). The service is using the [Google Vision API](https://cloud.google.com/vision/). In order to run the service you need to make a free account and obtain a Google vision API secret key



## 🔧 Build

In order to build the service you need to add the  `keys.json `  in the  `Config/ ` folder. The  `keys.json `  needs to have the following format.

![Screen Shot 2016-11-24 at 12.32.13 PM](./Screenshots/Screen Shot 2016-11-24 at 12.32.13 PM.png)



##  🏃 Run

In order to run the server locally on localhost 8080:

 `$ vapor build ` 

` $ vapor run serve`

or open it using Xcode and press run: (make sure that you have selected the App Scheme)

` $ vapor xcode -y`



## 🔧 Compatibility

The service has been tested on macOS and Ubuntu.



## 📱 Client App

You can find the client-app available on the [ App Store](https://itunes.apple.com/us/app/herocam/id1078111204?ls=1&mt=8). 

![Screen Shot 2016-11-24 at 1.39.14 PM](./Screenshots/Screen Shot 2016-11-24 at 1.39.14 PM.png)



## 🌐 Test

An example screenshot from Postman:

![Screen Shot 2016-11-24 at 12.10.33 PM](./Screenshots/Screen Shot 2016-11-24 at 12.10.33 PM.png)