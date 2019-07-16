/// This class is dedicated for help automate PMML project testing specifically
/// Which means this might only works under the specific PMML project environment 
/// Future modification is needed since some of the methods is too customized, compatibility and flexibility of these tools needs to be improved 
Class DataMining.PMML.Utilities
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
		
		set time = ##class(DataMining.PMML.Utilities).RunModelFromSQL(.resultID, "DataMining.PMML.Iris","","SELECT ID, PetalLength, PetalWidth, SepalLength, SepalWidth, Species FROM DataMining.IrisDataset",.fieldMap,.SQLPram,,)

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
		
		set time = ##class(DataMining.PMML.Utilities).RunModelFromSQLByArray(.resultID, "DataMining.PMML.Iris",modelName,"SELECT ID, PetalLength, PetalWidth, SepalLength, SepalWidth, Species FROM DataMining.IrisDataset",.fieldMap,.SQLPram,,)

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
			set temp = ##class(DataMining.PMML.Utilities).ExecutionTimeIris(modelPath, definitionClass)
		}
				
		return $$$OK
}

ClassMethod ExecutionTimeIrisBatchArray(modelPath As %String, definitionClass As %String, modelName As %String) As %Status
{
		for i=1:1:100 {
			set temp = ##class(DataMining.PMML.Utilities).ExecutionTimeIrisArray(modelPath, definitionClass, modelName)
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
		set time = ##class(DataMining.PMML.Utilities).RunModelFromSQL(.resultID, "DataMining.PMML.Iris","","SELECT ID, HostID, Latitude, Longitude, Price, MinimumNights, NumberOfReviews, ReviewsPerMonth, Availability, CalculatedHostListingsCount FROM DataMining_PMML.AirbnbDataset",.fieldMap,.SQLPram,,)
		set t4 = $zh
		
		set timeConsumedRunningModel = t4 - t3
		set timeConsumedCreatingPMML = t2 - t1
		
		
 //		set StoringTime = timeConsumedRunningModel - time
	
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
		
		
		
		
		set time = ##class(DataMining.PMML.Utilities).RunModelFromSQLByArrayAirbnb(.resultID, "DataMining.PMML.Iris",modelName,"SELECT ID, HostID, Latitude, Longitude, Price, MinimumNights, NumberOfReviews, ReviewsPerMonth, Availability, CalculatedHostListingsCount FROM DataMining_PMML.AirbnbDataset",.fieldMap,.SQLPram,,)

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
			set temp = ##class(DataMining.PMML.Utilities).ExecutionTimeAirbnbArray(modelPath, definitionClass, modelName)
		}
				
		return $$$OK
}




ClassMethod ExecutionTimeAirbnbBatch(modelPath As %String, definitionClass As %String) As %Status
{
		for i=1:1:100 {
			set temp = ##class(DataMining.PMML.Utilities).ExecutionTimeAirbnb(modelPath, definitionClass)
		}
				
		return $$$OK
}



/// This method is created for loading the Airbnb.csv data onto IRIS
/// Note that a dedicated Class 'DataMining.PMML.AirbnbDataset" mapped to the Airbnb.csv needs to be built and compiled beforehand
ClassMethod LoadAirbnbData(path As %String)
{
	set file = ##class(%File).%New(path)
	do file.Close()
    set sc = file.Open( "R" ) 
  
    
    if $$$ISERR(sc) {
    	do $system.Status.DisplayError(sc)
    	quit    ; or do smth
     }
    set str=file.ReadLine()
    while 'file.AtEnd {
         set str=file.ReadLine()
         set obj = ##class(DataMining.PMML.AirbnbDataset).%New()
            
            set obj.HostID = $piece( str, "," ,1 )
            set obj.Latitude = $piece( str, "," ,2 )
            set obj.Longitude = $piece( str, "," ,3 )
            set obj.Price = $piece( str, "," ,4 )
            set obj.MinimumNights = $piece( str, "," ,5 ) 
            set obj.NumberOfReviews = $piece( str, "," ,6 )

            set obj.ReviewsPerMonth = $piece( str, "," ,7 )
            
            set obj.CalculatedHostListingsCount = $piece( str, "," ,8 )
            
            set obj.Availability = $piece( str, "," ,9 )
            
            set status = obj.%Save()
            if $$$ISERR(status) {
            	do $system.Status.DisplayError(status)
            	quit    ; or do smth
    		}
           
       }
 
  	write !, "data should have saved to IRIS " _ " status: " _ status
    do file.Close()
}

ClassMethod LoadIrisData(path As %String)
{
	set file = ##class(%File).%New(path)
	do file.Close()
    set sc = file.Open( "R" ) 
  
    
    if $$$ISERR(sc) {
    	do $system.Status.DisplayError(sc)
    	quit    ; or do smth
     }
    set str=file.ReadLine()
    while 'file.AtEnd {
         set str=file.ReadLine()
         set obj = ##class(DataMining.PMML.ExternalIrisData).%New()
            
            
            set obj.SepalLength = $piece( str, "," ,1 )
            set obj.SepalWidth = $piece( str, "," ,2 )
            set obj.PetalLength = $piece( str, "," ,3 )
            set obj.PetalWidth = $piece( str, "," ,4 )
            set obj.Species = $piece( str, "," ,5 ) 
          
            
            set status = obj.%Save()
            if $$$ISERR(status) {
            	do $system.Status.DisplayError(status)
            	quit    ; or do smth
    		}
           
       }
 
  	write !, "Iris external data should have saved to IRIS " _ " status: " _ status
    do file.Close()
}

ClassMethod RunModelFromResultSet(ByRef pResultsId As %Integer, pDefinitionClass As %String, pModelName As %String = "", pResultSet As %ResultSet, ByRef pFieldMap, pResultsClass As %String = "%DeepSee.PMML.Utils.TempResult", pTracking As %Boolean = 0) As %ListOfDataTypes
{
	set tSC = $$$OK
	try {
	
		
		set tModelClass = $classmethod(pDefinitionClass, "%GetModelClassName", .pModelName)
		if (tModelClass="") {
			set tSC = $$$ERROR($$$GeneralError, pDefinitionClass_" does not contain a model named '"_pModelName_"'")
			quit
		}
		set tDataClass = $classmethod(pDefinitionClass, "%GetDataClassName")
		
		
		
		set tPredictedField = $classmethod(tModelClass, "%GetPredictedField")
		if (tPredictedField="") {
			set tSC = $$$ERROR($$$GeneralError, "Could not identify target field for model '"_tModelClass_"'")
			quit
		}
		
		
		
		set tTargetFieldCol = $g(pFieldMap(tPredictedField),tPredictedField)
		if '$d(pResultSet.%GetMetadata().columnIndex($$$UPPER(tTargetFieldCol))) {
		
			set tSC = $$$ERROR($$$GeneralError, "Test result set does not select the target field for this model: '"_tTargetFieldCol_"'")
			write !
			do $system.Status.DisplayError(tSC)
			write !
			quit
		}
		
		
		set tIDFieldCol = $g(pFieldMap("_ID"),"_ID")
		set tHasIDField = $d(pResultSet.%GetMetadata().columnIndex(tIDFieldCol))
		
		// if pFieldMap is empty, ensure it has data so pFieldMap will take precedence over
		// the default DataSource in %CreateFromResultSet
		set:'$d(pFieldMap) pFieldMap = 1
		
		if (pTracking) {
			set tTaskId = +$job
			set gBgrData = $name(^IRIS.Temp.PMML.BgrTask(tTaskId,"track"))
			
			// we cannot get the total number of rows for this pResultSet,
			// except if this comes from a %RunModelFromSQL call
			set tTotal = $s('$d(@gBgrData@("done")):$g(@gBgrData@("total"),-1), 1:-1)
			
			kill @gBgrData
			set @gBgrData@("start") = $zh
			set @gBgrData@("total") = tTotal
			set @gBgrData@("done") = 0
		}
		
		#dim tModel As %DeepSee.PMML.Model.AbstractModel
		set tModel = $classmethod(tModelClass, "%New")
		
		set:($g(pResultsId)="")||($g(pResultsId)=0) pResultsId = $classmethod(pResultsClass, "GetNewTestId")
		
		set tCount = 0
		set timeTotal = 0
		
		set timeTotalStoring = 0
		
		while pResultSet.%Next() {
			set tCount = tCount+1
			// get actual and predicted values for SQLquery result record
			set tActualValue = pResultSet.%Get(tTargetFieldCol)
			
			set tSC = $classmethod(tDataClass, "%CreateFromResultSet", pResultSet, .tInput, .pFieldMap)
			quit:$$$ISERR(tSC)
					
			
			set tStart = $zh
			
			set tSC = tModel.%ExecuteModel(tInput, .tOutput)
			set tEnd = $zh
			
			set resultTime = tEnd - tStart
			set timeTotal = timeTotal + resultTime
			
			quit:$$$ISERR(tSC)
			
			
			set tPredictedValue = tOutput.%GetFeatureValue("predictedValue", tPredictedField)
			set tProbability = tOutput.%GetFeatureValue("probability", tPredictedField)
			
			set tStoringStart = $zh
			
			set tResult = $classmethod(pResultsClass, "%New")
			set tResult.TestId = pResultsId
			set tResult.ModelClass = tModelClass
			set tResult.ActualValue = tActualValue
			set tResult.PredictedValue = tPredictedValue
			set tResult.Probability = tProbability
			set tResult.PredictTime = $zdt($ztimestamp,3)
			set tResult.TestRecordId = $s(tHasIDField:pResultSet.%Get(tIDFieldCol), 1:tCount)
			set tSC = tResult.%Save()
				
			set tStoringEnd = $zh
			
			
			
			set resultStoringTime = tStoringEnd - tStoringStart
			set timeTotalStoring = timeTotalStoring + resultStoringTime
			
			quit:$$$ISERR(tSC)
			
			set:pTracking&&'(tCount#10) ^IRIS.Temp.PMML.BgrTask(tTaskId,"track","done") = tCount
		}
		quit:$$$ISERR(tSC)
		
		set returnList=##class(%ListOfDataTypes).%New() 
		
		do returnList.Insert(timeTotal)
		do returnList.Insert(timeTotalStoring)
		
		set:pTracking ^IRIS.Temp.PMML.BgrTask(tTaskId,"track","done") = tCount
		
	} catch (ex) {
		set tSC = ex.AsStatus()
	}
	
	return returnList
	quit tSC
}

ClassMethod RunModelFromSQLArray(ByRef pResultsId As %Integer, pDefinitionClass As %String, pModelName As %String = "", pResultSet As %ResultSet, ByRef pFieldMap, pResultsClass As %String = "%DeepSee.PMML.Utils.TempResult", pTracking As %Boolean = 0) As %ListOfDataTypes
{
	set tSC = $$$OK
	try {
			
			
		set tModelClass = $classmethod(pDefinitionClass, "%GetModelClassName", .pModelName)
	
	
		if (tModelClass="") {
			set tSC = $$$ERROR($$$GeneralError, pDefinitionClass_" does not contain a model named '"_pModelName_"'")
			quit
		}
		
		
		set tDataClass = $classmethod(pDefinitionClass, "%GetDataClassName")
		
	
		
		set tPredictedField = $classmethod(tModelClass, "%GetPredictedField")
		if (tPredictedField="") {
			set tSC = $$$ERROR($$$GeneralError, "Could not identify target field for model '"_tModelClass_"'")
			quit
		}
		
		
		set tTargetFieldCol = $g(pFieldMap(tPredictedField),tPredictedField)

		
		if '$d(pResultSet.%GetMetadata().columnIndex($$$UPPER(tTargetFieldCol))) {

			set tSC = $$$ERROR($$$GeneralError, "Test result set does not select the target field for this model: '"_tTargetFieldCol_"'")
			write !
			do $system.Status.DisplayError(tSC)
			write !
			quit
		}
		

		set tIDFieldCol = $g(pFieldMap("_ID"),"_ID")
		set tHasIDField = $d(pResultSet.%GetMetadata().columnIndex(tIDFieldCol))
		
		// if pFieldMap is empty, ensure it has data so pFieldMap will take precedence over
		// the default DataSource in %CreateFromResultSet
		set:'$d(pFieldMap) pFieldMap = 1
		
		
		
		if (pTracking) {
			set tTaskId = +$job
			set gBgrData = $name(^IRIS.Temp.PMML.BgrTask(tTaskId,"track"))
			
			// we cannot get the total number of rows for this pResultSet,
			// except if this comes from a %RunModelFromSQL call
			set tTotal = $s('$d(@gBgrData@("done")):$g(@gBgrData@("total"),-1), 1:-1)
			
			kill @gBgrData
			set @gBgrData@("start") = $zh
			set @gBgrData@("total") = tTotal
			set @gBgrData@("done") = 0
		}
		
			
		
		#dim tModel As %DeepSee.PMML.Model.AbstractModel
		set tModel = $classmethod(tModelClass, "%New")
		
		set:($g(pResultsId)="")||($g(pResultsId)=0) pResultsId = $classmethod(pResultsClass, "GetNewTestId")
		
		set tCount = 0
		set timeTotal = 0
		
	
		set timeTotalStoring = 0
		
		
		while pResultSet.%Next() {


			set tCount = tCount+1
			// get actual and predicted values for SQLquery result record
			set tActualValue = pResultSet.%Get(tTargetFieldCol)
			
			set tSC = $classmethod(tDataClass, "%CreateFromResultSet", pResultSet, .tInput, .pFieldMap)
			
			
			quit:$$$ISERR(tSC)
			
			
			set input = $classmethod(pDefinitionClass _"." _pModelName_ "Input", "%New")
			
				
			set input.PetalLength = tInput.PetalLength
			set input.PetalWidth = tInput.PetalWidth
			set input.SepalLength = tInput.SepalLength
			set input.SepalWidth = tInput.SepalWidth
			
		
			set stat = input.%GetAsArray(.out,,)
			
	

			do $system.Status.DisplayError(stat)
			
			
			set tStart = $zh
						
			
			set tSC = tModel.%ExecuteModel(.out, .tOutput)
			
			
			set tEnd = $zh
			
			set resultTime = tEnd - tStart
			set timeTotal = timeTotal + resultTime
			quit:$$$ISERR(tSC)
			
			
			set tPredictedValue = tOutput.%GetFeatureValue("predictedValue", tPredictedField)
			set tProbability = tOutput.%GetFeatureValue("probability", tPredictedField)
			
			set tStoringStart = $zh
			
			set tResult = $classmethod(pResultsClass, "%New")
			set tResult.TestId = pResultsId
			set tResult.ModelClass = tModelClass
			set tResult.ActualValue = tActualValue
			set tResult.PredictedValue = tPredictedValue
			set tResult.Probability = tProbability
			set tResult.PredictTime = $zdt($ztimestamp,3)
			set tResult.TestRecordId = $s(tHasIDField:pResultSet.%Get(tIDFieldCol), 1:tCount)
			set tSC = tResult.%Save()
				
			set tStoringEnd = $zh
			
			
			
			set resultStoringTime = tStoringEnd - tStoringStart
			set timeTotalStoring = timeTotalStoring + resultStoringTime
			
			quit:$$$ISERR(tSC)
			
			set:pTracking&&'(tCount#10) ^IRIS.Temp.PMML.BgrTask(tTaskId,"track","done") = tCount
		}
		quit:$$$ISERR(tSC)
		
		set returnList=##class(%ListOfDataTypes).%New() 
		
		do returnList.Insert(timeTotal)
		do returnList.Insert(timeTotalStoring)
		
		set:pTracking ^IRIS.Temp.PMML.BgrTask(tTaskId,"track","done") = tCount
		
	} catch (ex) {
		set tSC = ex.AsStatus()
	}
 
	return returnList
	quit tSC
}



ClassMethod RunModelFromSQLAirbnbArray(ByRef pResultsId As %Integer, pDefinitionClass As %String, pModelName As %String = "", pResultSet As %ResultSet, ByRef pFieldMap, pResultsClass As %String = "%DeepSee.PMML.Utils.TempResult", pTracking As %Boolean = 0) As %ListOfDataTypes
{
	set tSC = $$$OK
	try {
			
			
		set tModelClass = $classmethod(pDefinitionClass, "%GetModelClassName", .pModelName)
		if (tModelClass="") {
			set tSC = $$$ERROR($$$GeneralError, pDefinitionClass_" does not contain a model named '"_pModelName_"'")
			quit
		}
		set tDataClass = $classmethod(pDefinitionClass, "%GetDataClassName")
		
		
		
		set tPredictedField = $classmethod(tModelClass, "%GetPredictedField")
		if (tPredictedField="") {
			set tSC = $$$ERROR($$$GeneralError, "Could not identify target field for model '"_tModelClass_"'")
			quit
		}
		
		
		set tTargetFieldCol = $g(pFieldMap(tPredictedField),tPredictedField)
		
		
		if '$d(pResultSet.%GetMetadata().columnIndex($$$UPPER(tTargetFieldCol))) {

			set tSC = $$$ERROR($$$GeneralError, "Test result set does not select the target field for this model: '"_tTargetFieldCol_"'")
			write !
			do $system.Status.DisplayError(tSC)
			write !
			quit
		}
		

		set tIDFieldCol = $g(pFieldMap("_ID"),"_ID")
		set tHasIDField = $d(pResultSet.%GetMetadata().columnIndex(tIDFieldCol))
		
		// if pFieldMap is empty, ensure it has data so pFieldMap will take precedence over
		// the default DataSource in %CreateFromResultSet
		set:'$d(pFieldMap) pFieldMap = 1
		
		
		if (pTracking) {
			set tTaskId = +$job
			set gBgrData = $name(^IRIS.Temp.PMML.BgrTask(tTaskId,"track"))
			
			// we cannot get the total number of rows for this pResultSet,
			// except if this comes from a %RunModelFromSQL call
			set tTotal = $s('$d(@gBgrData@("done")):$g(@gBgrData@("total"),-1), 1:-1)
			
			kill @gBgrData
			set @gBgrData@("start") = $zh
			set @gBgrData@("total") = tTotal
			set @gBgrData@("done") = 0
		}
		
		#dim tModel As %DeepSee.PMML.Model.AbstractModel
		set tModel = $classmethod(tModelClass, "%New")
		
		set:($g(pResultsId)="")||($g(pResultsId)=0) pResultsId = $classmethod(pResultsClass, "GetNewTestId")
		
		set tCount = 0
		set timeTotal = 0
		
	
		set timeTotalStoring = 0
		
		
		while pResultSet.%Next() {
			set tCount = tCount+1
			// get actual and predicted values for SQLquery result record
			set tActualValue = pResultSet.%Get(tTargetFieldCol)
			
			set tSC = $classmethod(tDataClass, "%CreateFromResultSet", pResultSet, .tInput, .pFieldMap)
			quit:$$$ISERR(tSC)
			
			
			
			
			set input = $classmethod(pDefinitionClass _"." _ pModelName _ "Input", "%New")
 
				
			set input.calculatedhostlistingscount = tInput.calculatedhostlistingscount
			set input.hostid = tInput.hostid
			set input.latitude = tInput.latitude
			set input.longitude = tInput.longitude
			set input.minimumnights = tInput.minimumnights
			set input.numberofreviews = tInput.numberofreviews
			set input.price = tInput.price
			set input.roomtype = tInput.roomtype
			
			
			set stat = input.%GetAsArray(.out,,)

			do $system.Status.DisplayError(stat)
			
			set tStart = $zh
			
			
			set tSC = tModel.%ExecuteModel(.out, .tOutput)
			
			
			set tEnd = $zh
			
			set resultTime = tEnd - tStart
			set timeTotal = timeTotal + resultTime
			quit:$$$ISERR(tSC)
			
			
			set tPredictedValue = tOutput.%GetFeatureValue("predictedValue", tPredictedField)
			set tProbability = tOutput.%GetFeatureValue("probability", tPredictedField)
			
			set tStoringStart = $zh
			
			set tResult = $classmethod(pResultsClass, "%New")
			set tResult.TestId = pResultsId
			set tResult.ModelClass = tModelClass
			set tResult.ActualValue = tActualValue
			set tResult.PredictedValue = tPredictedValue
			set tResult.Probability = tProbability
			set tResult.PredictTime = $zdt($ztimestamp,3)
			set tResult.TestRecordId = $s(tHasIDField:pResultSet.%Get(tIDFieldCol), 1:tCount)
			set tSC = tResult.%Save()
				
			set tStoringEnd = $zh
			
			
			
			set resultStoringTime = tStoringEnd - tStoringStart
			set timeTotalStoring = timeTotalStoring + resultStoringTime
			
			quit:$$$ISERR(tSC)
			
			set:pTracking&&'(tCount#10) ^IRIS.Temp.PMML.BgrTask(tTaskId,"track","done") = tCount
		}
		quit:$$$ISERR(tSC)
		
		set returnList=##class(%ListOfDataTypes).%New() 
		
		do returnList.Insert(timeTotal)
		do returnList.Insert(timeTotalStoring)
		
		set:pTracking ^IRIS.Temp.PMML.BgrTask(tTaskId,"track","done") = tCount
		
	} catch (ex) {
		set tSC = ex.AsStatus()
	}
 
	return returnList
	quit tSC
}




ClassMethod RunModelFromSQL(ByRef pResultsId As %Integer, pDefinitionClass As %String, pModelName As %String = "", pSQL As %String, ByRef pFieldMap, ByRef pSQLParams, pResultsClass As %String = "%DeepSee.PMML.Utils.TempResult", pTracking As %Boolean = 0) As %ListOfDataTypes
{
	set tSC = $$$OK
	try {
		
		if (pTracking) {
			set tTaskId = +$job
			set tStatement = ##class(%SQL.Statement).%New()
			set tSC = tStatement.%Prepare("SELECT COUNT(*) FROM ("_pSQL_")")
			quit:$$$ISERR(tSC)
			set tResultSet = tStatement.%Execute(pSQLParams...)
			if tResultSet.%Next() {
				set tTotal = tResultSet.%GetData(1)
			} else {
				set tTotal = 0
			}
			
			// just set the total, further status info will be handled by %RunModelFromResultSet()
			kill ^IRIS.Temp.PMML.BgrTask(tTaskId,"track")
			set ^IRIS.Temp.PMML.BgrTask(tTaskId,"track","total") = tTotal
		}
		
		set tStatement = ##class(%SQL.Statement).%New()
		set tSC = tStatement.%Prepare(pSQL)
		quit:$$$ISERR(tSC)
		
		kill %objlasterror
		
		set tResultSet = tStatement.%Execute(pSQLParams...)
		 
		set tSC = $g(%objlasterror, $$$OK)
		quit:$$$ISERR(tSC) 
		

		set d = ##class(DataMining.PMML.Utilities).RunModelFromResultSet(.pResultsId, pDefinitionClass, pModelName, .tResultSet, .pFieldMap, pResultsClass, pTracking)
		
		zwrite rResultSet
		
	} catch (ex) {
		set tSC = ex.AsStatus()
	}
	
	return d
	quit tSC
}




ClassMethod RunModelFromSQLByArrayAirbnb(ByRef pResultsId As %Integer, pDefinitionClass As %String, pModelName As %String = "", pSQL As %String, ByRef pFieldMap, ByRef pSQLParams, pResultsClass As %String = "%DeepSee.PMML.Utils.TempResult", pTracking As %Boolean = 0) As %ListOfDataTypes
{
	set tSC = $$$OK
	try {
		
		if (pTracking) {
			set tTaskId = +$job
			set tStatement = ##class(%SQL.Statement).%New()
			set tSC = tStatement.%Prepare("SELECT COUNT(*) FROM ("_pSQL_")")
			quit:$$$ISERR(tSC)
			set tResultSet = tStatement.%Execute(pSQLParams...)
			if tResultSet.%Next() {
				set tTotal = tResultSet.%GetData(1)
			} else {
				set tTotal = 0
			}
			
	
			kill ^IRIS.Temp.PMML.BgrTask(tTaskId,"track")
			set ^IRIS.Temp.PMML.BgrTask(tTaskId,"track","total") = tTotal
		}
		
		set tStatement = ##class(%SQL.Statement).%New()
		set tSC = tStatement.%Prepare(pSQL)
		quit:$$$ISERR(tSC)
		
		kill %objlasterror
		
		set tResultSet = tStatement.%Execute(pSQLParams...)
		 
		set tSC = $g(%objlasterror, $$$OK)
		quit:$$$ISERR(tSC) 
		
		
		
	
		set d = ##class(DataMining.PMML.Utilities).RunModelFromSQLAirbnbArray(.pResultsId, pDefinitionClass, pModelName, .tResultSet, .pFieldMap, pResultsClass, pTracking)
		
		
	} catch (ex) {
		set tSC = ex.AsStatus()
	}
	
	return d
	quit tSC
}


ClassMethod RunModelFromSQLByArray(ByRef pResultsId As %Integer, pDefinitionClass As %String, pModelName As %String = "", pSQL As %String, ByRef pFieldMap, ByRef pSQLParams, pResultsClass As %String = "%DeepSee.PMML.Utils.TempResult", pTracking As %Boolean = 0) As %ListOfDataTypes
{
	set tSC = $$$OK
	try {
		
		if (pTracking) {
			set tTaskId = +$job
			set tStatement = ##class(%SQL.Statement).%New()
			set tSC = tStatement.%Prepare("SELECT COUNT(*) FROM ("_pSQL_")")
			quit:$$$ISERR(tSC)
			set tResultSet = tStatement.%Execute(pSQLParams...)
			if tResultSet.%Next() {
				set tTotal = tResultSet.%GetData(1)
			} else {
				set tTotal = 0
			}
			
	
			kill ^IRIS.Temp.PMML.BgrTask(tTaskId,"track")
			set ^IRIS.Temp.PMML.BgrTask(tTaskId,"track","total") = tTotal
		}
		
		set tStatement = ##class(%SQL.Statement).%New()
		set tSC = tStatement.%Prepare(pSQL)
		quit:$$$ISERR(tSC)
		
		kill %objlasterror
		
		set tResultSet = tStatement.%Execute(pSQLParams...)
		 
		set tSC = $g(%objlasterror, $$$OK)
		quit:$$$ISERR(tSC) 
		
		
		
		
		set d = ##class(DataMining.PMML.Utilities).RunModelFromSQLArray(.pResultsId, pDefinitionClass, pModelName, .tResultSet, .pFieldMap, pResultsClass, pTracking)
		
		
		
	} catch (ex) {
		set tSC = ex.AsStatus()
	}
	
	return d
	quit tSC
}

}
