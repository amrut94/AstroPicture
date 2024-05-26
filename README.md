# AstroPicture App

AstroPicture is an iOS app designed to showcase astronomy pictures of the day (APOD) sourced from NASA's Astronomy Picture of the Day (APOD) API. It allows users to view a collection of stunning astronomy images along with their titles, dates, and descriptions. Users can also tap on an image to view more details.

## Features

- Browse a collection of astronomy images fetched from NASA's APOD API.
- View detailed information about each astronomy image, including title, date, and description.
- Tap on an image to view it in full-screen mode with additional details.

## Screenshots

![Astro_Picture_Img1](https://github.com/amrut94/AstroPicture/assets/66714609/65cd225c-8318-43a0-897e-b0f7d68839f0)
![Astro_Picture_Img2](https://github.com/amrut94/AstroPicture/assets/66714609/3e3b8e2c-2c65-4888-8d3e-02ff13abaa48)


## Requirements

- iOS 13.0+
- Xcode 12.0+
- Swift 5.0+

## Installation

1. Clone the repository:

2. Open the project in Xcode.

3. Build and run the app on a simulator or physical device.

## Usage

1. Upon launching the app, the main screen displays a list of astronomy images fetched from NASA's APOD API.

2. Scroll through the list to browse different images.

3. Tap on an image to view its details, including the title, date, and description.

4. Swipe left or right to navigate between images in full-screen mode.

5. Enjoy exploring the wonders of the universe!

## Architecture

The AstroPicture app follows the MVVM (Model-View-ViewModel) architecture pattern to separate concerns and improve testability and maintainability. The key components of the architecture include:

- **Model**: Represents the data entities used in the app, such as Apod (Astronomy Picture of the Day).
- **View**: Represents the user interface elements, including ViewControllers and custom views.
- **ViewModel**: Acts as an intermediary between the View and Model layers, providing data and business logic to the View.

## Dependencies

- [SDWebImage](https://github.com/SDWebImage/SDWebImage): For asynchronous loading and caching of images.
- [Combine](https://developer.apple.com/documentation/combine): For handling asynchronous operations and reactive programming.
- [UIKit](https://developer.apple.com/documentation/uikit): For building the user interface components.

## Credits

- This app uses data from NASA's Astronomy Picture of the Day (APOD) API. Visit [NASA APOD API](https://api.nasa.gov/) for more information.

## Author

[Amrut Waghmare]

## Acknowledgements

Special thanks to [NASA](https://www.nasa.gov/) for providing the APOD API and inspiring curiosity about the universe.
