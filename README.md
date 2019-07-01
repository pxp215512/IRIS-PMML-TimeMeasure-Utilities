# IRIS-PMML-TimeMeasure-Utilities
This is an example of measuring accurate time consumptions of IRIS PMML operations.

Classes
1. AirbnbDataset: A %Persistent class to contain the Airbnb.csv data loaded externally
2. Iris: The class to contain the PMML model
3. RuntimeAirbnb: A %Persistent class to store the time measurement result of various models running against AirbnbDataset 



Setting up steps:
1. import these files into Studio or Atelier. 
2. Compile all files
3. open up the IRIS terminal and run do ##class(DataMining.PMML.Utilities).LoadAirbnbData("PATH-TO-Airbnb.csv-FILE") to load the Airbnb dataset into IRIS
4. All set and methods in DataMining.PMML.Utilities can be executed to measure the various execution time
