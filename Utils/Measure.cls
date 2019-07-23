Class DataMining.PMML.Utils.Measure
{

	/// This method requires the pmml model's absolute path and the Class that will contain the created PMML definition as input
	/// The result will show the PMML model execution time comsumed using Iris dataset  
	ClassMethod ExecutionTimeIris(modelPath As %String, definitionClass As %String) As %Status
	{
			
	
	 		set t1 = $zh
			set status = ##class(%DeepSee.PMML.Utils).CreateFromFile(modelPath, definitionClass, , , )
			set t2 = $zh
	 	
			
			if $$$ISERR(status) {
				write !, "error occurred when creating PMML definitions: " ,!
	        	do $system.Status.DisplayError(status)
	        	quit    ; or do smth
			}
			
	 	
	 		set t3 = $zh
			
			set time = ##class(DataMining.PMML.Utils.DefaultMode).RunModelFromSQL(.resultID, "DataMining.PMML.Iris","","SELECT ID, PetalLength, PetalWidth, SepalLength, SepalWidth, Species FROM DataMining.IrisDataset",.fieldMap,.SQLPram,,)
	
			set t4 = $zh
			
			set timeConsumedRunningModel = t4 - t3
			set timeConsumedCreatingPMML = t2 - t1
			
			
			set StoringTime = time.GetAt(2)
		
			write !, "================Running time for "_ $p(modelPath, "\" , *) _ ":=========PMMLCreationTime=====" _ timeConsumedCreatingPMML _ " =====Storing time ======" _ time.GetAt(2) _ " seconds", !
			
			write !, "===============================Pure Execution time: " _ time.GetAt(1) ,!
			
			set obj = ##class(DataMining.PMML.RuntimeIris).%New()
	            
	        set obj.Model = $p(modelPath, "\" , *)
	
	        set obj.CreationTime = timeConsumedCreatingPMML
	        
	        set obj.StoringTime = time.GetAt(2)
	        
	        set obj.PureExecutionTime = time.GetAt(1)
	        
	        
	        set status = obj.%Save()
	        if $$$ISERR(status) {
	        	do $system.Status.DisplayError(status)
	        	quit    ; or do smth
			}
	
			return $$$OK
	}
	
	ClassMethod ExecutionTimeIrisArray(modelPath As %String, definitionClass As %String, modelName AS %String) As %Status
	{
			
	
	 		set t1 = $zh
			set status = ##class(%DeepSee.PMML.Utils).CreateFromFile(modelPath, definitionClass, , , )
			set t2 = $zh
	 	
			
			if $$$ISERR(status) {
				write !, "error occurred when creating PMML definitions: " ,!
	        	do $system.Status.DisplayError(status)
	        	quit    ; or do smth
			}
			
	 	
	 		set t3 = $zh
			
			set time = ##class(DataMining.PMML.Utils.SimpleMode).RunModelFromSQLByArray(.resultID, "DataMining.PMML.Iris",modelName,"SELECT ID, PetalLength, PetalWidth, SepalLength, SepalWidth, Species FROM DataMining.IrisDataset",.fieldMap,.SQLPram,,)
	
			set t4 = $zh
			
			set timeConsumedRunningModel = t4 - t3
			set timeConsumedCreatingPMML = t2 - t1
			
			
		
			write !, "================Running time for "_ $p(modelPath, "\" , *) _ ":=========PMMLCreationTime=====" _ timeConsumedCreatingPMML _ " =====Storing time ======" _ time.GetAt(2)_ " seconds", !
			
			write !, "===============================Pure Execution time: " _ time.GetAt(1) ,!
			
			set obj = ##class(DataMining.PMML.RuntimeIrisArray).%New()
	            
	        set obj.Model = $p(modelPath, "\" , *)
	
	        set obj.CreationTime = timeConsumedCreatingPMML
	        
	        set obj.StoringTime = time.GetAt(2)
	        
	        set obj.PureExecutionTime = time.GetAt(1)
	        
	        
	        set status = obj.%Save()
	        if $$$ISERR(status) {
	        	do $system.Status.DisplayError(status)
	        	quit    ; or do smth
			}
	
			return $$$OK
	}
	
	ClassMethod ExecutionTimeIrisBatch(modelPath As %String, definitionClass As %String) As %Status
	{
			for i=1:1:100 {
				set temp = ##class(DataMining.PMML.Utils.Measure).ExecutionTimeIris(modelPath, definitionClass)
			}
					
			return $$$OK
	}
	
	ClassMethod ExecutionTimeIrisBatchArray(modelPath As %String, definitionClass As %String, modelName As %String) As %Status
	{
			for i=1:1:100 {
				set temp = ##class(DataMining.PMML.Utils.Measure).ExecutionTimeIrisArray(modelPath, definitionClass, modelName)
			}
					
			return $$$OK
	}
	
	/// This method requires the pmml model's absolute path and the Class that will contain the created PMML definition as input
	/// The result will show the PMML model execution time comsumed using Airbnb dataset  
	ClassMethod ExecutionTimeAirbnb(modelPath As %String, definitionClass As %String) As %Status
	{
					
	 		set t1 = $zh
			set status = ##class(%DeepSee.PMML.Utils).CreateFromFile(modelPath, definitionClass, , , )
			set t2 = $zh
	 	
			
			if $$$ISERR(status) {
				write !, "error occurred when creating PMML definitions: " ,!
	        	do $system.Status.DisplayError(status)
	        	quit    ; or do smth
			}
			
			
			
	 		set t3 = $zh	
			set time = ##class(DataMining.PMML.Utils.DefaultMode).RunModelFromSQL(.resultID, "DataMining.PMML.Iris","","SELECT ID, HostID, Latitude, Longitude, Price, MinimumNights, NumberOfReviews, ReviewsPerMonth, Availability, CalculatedHostListingsCount FROM DataMining_PMML.AirbnbDataset",.fieldMap,.SQLPram,,)
			set t4 = $zh
			
			set timeConsumedRunningModel = t4 - t3
			set timeConsumedCreatingPMML = t2 - t1
			
		
			write !, "================Running time for "_ $p(modelPath, "\" , *) _ ":=========PMMLCreationTime=====" _ timeConsumedCreatingPMML _ " =====Storing time ======" _ time.GetAt(2) _ " seconds", !
			
			write !, "===============================Pure Execution time: " _ time.GetAt(1) ,!
			
			set obj = ##class(DataMining.PMML.RuntimeAirbnb).%New()
	            
	        set obj.Model = $p(modelPath, "\" , *)
	
	        set obj.CreationTime = timeConsumedCreatingPMML
	        
	        set obj.StoringTime = time.GetAt(2)
	        
	        set obj.PureExecutionTime = time.GetAt(1)
	        
	        set status = obj.%Save()
	        if $$$ISERR(status) {
	        	do $system.Status.DisplayError(status)
	        	quit    ; or do smth
			}
	
			return $$$OK
	}
	
	
	
	
	
	
	
	ClassMethod ExecutionTimeAirbnbArray(modelPath As %String, definitionClass As %String, modelName AS %String) As %Status
	{
			
	
	 		set t1 = $zh
			set status = ##class(%DeepSee.PMML.Utils).CreateFromFile(modelPath, definitionClass, , , )
			set t2 = $zh
	 	
			
			if $$$ISERR(status) {
				write !, "error occurred when creating PMML definitions: " ,!
	        	do $system.Status.DisplayError(status)
	        	quit    ; or do smth
			}
			
	 	
	 		set t3 = $zh
			
			
			set time = ##class(DataMining.PMML.Utils.SimpleMode).RunModelFromSQLByArrayAirbnb(.resultID, "DataMining.PMML.Iris",modelName,"SELECT ID, HostID, Latitude, Longitude, Price, MinimumNights, NumberOfReviews, ReviewsPerMonth, Availability, CalculatedHostListingsCount FROM DataMining_PMML.AirbnbDataset",.fieldMap,.SQLPram,,)
	
			set t4 = $zh
			
			set timeConsumedRunningModel = t4 - t3
			set timeConsumedCreatingPMML = t2 - t1
			
			
		
			write !, "================Running time for "_ $p(modelPath, "\" , *) _ ":=========PMMLCreationTime=====" _ timeConsumedCreatingPMML _ " =====Storing time ======" _ time.GetAt(2)_ " seconds", !
			
			write !, "===============================Pure Execution time: " _ time.GetAt(1) ,!
			
			set obj = ##class(DataMining.PMML.RuntimeAirbnbArray).%New()
	            
	        set obj.Model = $p(modelPath, "\" , *)
	
	        set obj.CreationTime = timeConsumedCreatingPMML
	        
	        set obj.StoringTime = time.GetAt(2)
	        
	        set obj.PureExecutionTime = time.GetAt(1)
	        
	        
	        set status = obj.%Save()
	        if $$$ISERR(status) {
	        	do $system.Status.DisplayError(status)
	        	quit    ; or do smth
			}
	
			return $$$OK
	}
	
	
	
	
	ClassMethod ExecutionTimeAirbnbBatchArray(modelPath As %String, definitionClass As %String, modelName As %String) As %Status
	{
			for i=1:1:100 {
				set temp = ##class(DataMining.PMML.Utils.Measure).ExecutionTimeAirbnbArray(modelPath, definitionClass, modelName)
			}
					
			return $$$OK
	}
	
	
	
	
	ClassMethod ExecutionTimeAirbnbBatch(modelPath As %String, definitionClass As %String) As %Status
	{
			for i=1:1:100 {
				set temp = ##class(DataMining.PMML.Utils.Measure).ExecutionTimeAirbnb(modelPath, definitionClass)
			}
					
			return $$$OK
	}




}