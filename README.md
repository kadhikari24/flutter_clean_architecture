Flutter Clean Architecture


A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

#Overview
1. This application uses the clean architecture for build flutter application
2. The main goal of the clean achitecture is to decouple the business logics and design.  It means code maintainable and testable.
3. If you are looking for the best practices and don't known how to segregate the logics into pacakages and modules, you can checkout this project.


#Libraries uses in this project
1. Retrofit, retrofit_generator and Dio  - for fetching rest api, for generating generated classes for retrofit
2. flutter_svg : We should use svg images for icons as are application runs in different screen sizes, Also the size of svg images are relatively smaller as combine to png images
3.json_serializable : This packages helps in creating model classes for api responses, use serializable to speed up creating model classes
4. dartz : This packages provide  Either object/class which I used to get responses and handle the error efficiently using methods available in this class
5.data_connection_checker : this package is used to check the internet connectivity in mobile application, If you are looking for building the web application too then this package will throw platform error, So you need to add a check.
6.pretty_dio_logger : It provides a reading logging format to log the dio
7. shared_preferences: Used this packages to save the key pair value in local database.
8. device_info : Devices info packages helps in getting the devices info. Add platform check before fetching the devices check.
9. freezed : Used this package to create a model changes which will generate model classes for more capabilities
10. get_it : Get it is best way for dependency Injection in flutter. Your view classes don't need to initialize all the dependencies and you can create a singleton, and many more.
11. lottie : You need some animated images or gif, Go for this library.
12. country_code_picker : Provide the dialog for picker country code. Use this widget in your register pages.
13. image_picker : Uses this packages for handling camera and gallery images. 
14. file_picker: As image_picker is not avilable in desktop, so use the file_picker for the desktop
15. rxdart: rxDart provides an
