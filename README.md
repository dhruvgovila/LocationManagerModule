# LocationManagerModule

In this module the Location Tracking of the device, that is to get the current location, is being performed in one class. The class is singleton so the object can be accessed from any object/viewcontroller.

The Code is written in ObjC and can be implemented in Swift Project by using Bridging Header.

Global Functions are defined to start or stop the location update anytime.

This module can be used:
1. To get the current location at one object, thus restraining the user from creating a LocationTracker object at every controller
2. Get the continous update of location at any place (object/viewcontroller) by assigning the delegate variable to the current object/viewcontroller 
3. The user can further modifyi it to add his/her own business logic like calculation of distance & speed or to update the current location to server.

