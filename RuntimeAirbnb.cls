Class DataMining.PMML.RuntimeAirbnb Extends %Persistent
{
	Property Model As %String;
	
	Property PureExecutionTime As %Double;
	
	Property CreationTime As %Double;
	
	Property StoringTime As %Double;

Storage Default
{
<Data name="RuntimeAirbnbDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>Model</Value>
</Value>
<Value name="3">
<Value>PureExecutionTime</Value>
</Value>
<Value name="4">
<Value>CreationTime</Value>
</Value>
<Value name="5">
<Value>StoringTime</Value>
</Value>
</Data>
<DataLocation>^DataMining.PMML.RuntimeAirbnbD</DataLocation>
<DefaultData>RuntimeAirbnbDefaultData</DefaultData>
<IdLocation>^DataMining.PMML.RuntimeAirbnbD</IdLocation>
<IndexLocation>^DataMining.PMML.RuntimeAirbnbI</IndexLocation>
<StreamLocation>^DataMining.PMML.RuntimeAirbnbS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}