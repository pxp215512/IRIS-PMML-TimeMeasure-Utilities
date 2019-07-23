Class DataMining.PMML.Utils.SimpleMode
{

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
			
			
			
		
			set d = ##class(DataMining.PMML.Utils.SimpleMode).RunModelFromSQLAirbnbArray(.pResultsId, pDefinitionClass, pModelName, .tResultSet, .pFieldMap, pResultsClass, pTracking)
			
			
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
			
			
			
			
			set d = ##class(DataMining.PMML.Utils.SimpleMode).RunModelFromSQLArray(.pResultsId, pDefinitionClass, pModelName, .tResultSet, .pFieldMap, pResultsClass, pTracking)
			
			
			
		} catch (ex) {
			set tSC = ex.AsStatus()
		}
		
		return d
		quit tSC
	}





}