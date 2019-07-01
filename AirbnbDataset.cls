/// This is the class mapped to Airbnb.csv dataset
Class DataMining.PMML.AirbnbDataset Extends %Persistent
{
	Property HostID As %Integer;
	
	Property Latitude As %Double;
	
	Property Longitude As %Double;
	
	Property Price As %Integer;
	
	Property MinimumNights As %Integer;
	
	Property NumberOfReviews As %Integer;
	
	Property ReviewsPerMonth As %Double;
	
	Property CalculatedHostListingsCount As %Integer;
	
	Property Availability As %Integer;

Storage Default
{
<Data name="AirbnbDatasetDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>HostID</Value>
</Value>
<Value name="3">
<Value>Latitude</Value>
</Value>
<Value name="4">
<Value>Longitude</Value>
</Value>
<Value name="5">
<Value>Price</Value>
</Value>
<Value name="6">
<Value>MinimumNights</Value>
</Value>
<Value name="7">
<Value>NumberOfReviews</Value>
</Value>
<Value name="8">
<Value>ReviewsPerMonth</Value>
</Value>
<Value name="9">
<Value>CalculatedHostListingsCount</Value>
</Value>
<Value name="10">
<Value>availability</Value>
</Value>
<Value name="11">
<Value>Availability</Value>
</Value>
</Data>
<DataLocation>^DataMining.PMML.AirbnbDatasetD</DataLocation>
<DefaultData>AirbnbDatasetDefaultData</DefaultData>
<IdLocation>^DataMining.PMML.AirbnbDatasetD</IdLocation>
<IndexLocation>^DataMining.PMML.AirbnbDatasetI</IndexLocation>
<StreamLocation>^DataMining.PMML.AirbnbDatasetS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}