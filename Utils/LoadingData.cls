Class DataMining.PMML.Utils.LoadingData
{

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


}