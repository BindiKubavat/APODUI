# APODUI
Integrated Nasa's APOD Apis

To load and Display the APOD below are 2 iOS Frameworks I have created: 

1.** NetworkKit** -> Stand alone framework to interact with network services. 
Can be integrated with any application which required service interaction.

     Tasks: 
        - normal data task with generic data parsing        
        - Data task to download the image       
        - User defined error handled 
        
2. **APODKit** -> Stand alone framework which manages the urls and models related to APOD api.  -> it has a dependency on the Network kit to make api call
       Tasks: 
	- generate a dynamic url based on the parameter 
  - **can be extensible to all type of nasa’s public apis**
	- make an api call to get the data for the day and download the image for respective module


- **APODUI** -> It is a project which is dependent on above 2 libraries. It includes the UI part to load the images and persist 10 images.
       - It includes 2 modules: 
          - APOD
             - to load the data and display            
             - Save the data locally 
          - Recently Visited             
              - Load the last 10 visited APODs  



**It includes   
 **- MVVM    **
**- Dark mode support in APOD screen **
**- Unit test cases for NetwrokKit**
**- screen size and orientation handled**
**- Subscript for user defaults**
**- code robustness ****
