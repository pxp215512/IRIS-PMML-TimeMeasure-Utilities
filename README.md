# IRIS-PMML-TimeMeasure-Utilities

This is an example of measuring accurate time consumptions of IRIS PMML operations.

Classes
1. AirbnbDataset: A %Persistent class to contain the Airbnb.csv data loaded externally
2. Iris: The class to contain the PMML model
3. RuntimeIris: A %Persistent class to store the time measurement result of various models running against Iris dataset 
4. RuntimeAirbnb: A %Persistent class to store the time measurement result of various models running against Airbnb dataset 
5. IrisDataset: A %Persistent class to store the default Iris dataset from https://github.com/intersystems/Samples-Data-Mining
6. ExternalIrisDatset: A %Persistent class to store the Iris data loaded from the external source
7. RuntimeIrisArray: A %Persistent class to store the time measurement result of various models running against Iris dataset in Simple Mode
8. RuntimeAirbnbArray: A %Persistent class to store the time measurement result of various models running against Airbnb dataset in Simple Mode



Setting up steps:
1. Import these files into Studio or Atelier. 
2. Compile all files
3. Open up the IRIS terminal and run "do##class(DataMining.PMML.Utils.LoadingData).LoadAirbnbData()" to load the Airbnb dataset into IRIS(Or load external Iris dataset using corresponding methods)
4. All set and methods in DataMining.PMML.Utils.Measure can be executed to measure the various execution time
5. See detail instructions in the Utils folder README
