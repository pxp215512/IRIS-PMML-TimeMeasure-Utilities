/// Class to store the measured execution and creating model time 
Class DataMining.PMML.RuntimeIris Extends %Persistent
{
	
	Property Model As %String;
	
	Property PureExecutionTime As %Double;
	
	Property CreationTime As %Double;
	
	Property StoringTime As %Double;
	
Storage Default
{
<Data name="RuntimeIrisDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>Model</Value>
</Value>
<Value name="3">
<Value>ExecutionTime</Value>
</Value>
<Value name="4">
<Value>CreationTime</Value>
</Value>
<Value name="5">
<Value>ExecutionTimeStore</Value>
</Value>
<Value name="6">
<Value>PureExecutionTime</Value>
</Value>
<Value name="7">
<Value>StoringTime</Value>
</Value>
</Data>
<DataLocation>^DataMining.PMML.RuntimeIrisD</DataLocation>
<DefaultData>RuntimeIrisDefaultData</DefaultData>
<IdLocation>^DataMining.PMML.RuntimeIrisD</IdLocation>
<IndexLocation>^DataMining.PMML.RuntimeIrisI</IndexLocation>
<StreamLocation>^DataMining.PMML.RuntimeIrisS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}