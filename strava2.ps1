$uri = "https://www.strava.com/api/v3/athlete/activities?access_token=ACCESSTOKENGOESHERE"
$result = Invoke-RestMethod -Uri $uri -Method Get

$activities = @()

foreach ($activity in $result)
{
	$objActivity = New-Object System.Object
	
	$objActivity | Add-Member -type NoteProperty -name Date -value $activity.start_date.substring(0,10)
	$objActivity | Add-Member -type NoteProperty -name Distance -value ("{0:N1}" -f ($activity.distance * 0.00062137))
	
	$ts = [timespan]::fromseconds($activity.moving_time)
	
	$objActivity | Add-Member -type NoteProperty -name Time -value $ts.ToString("hh\:mm\:ss")
	$objActivity | Add-Member -type NoteProperty -name AvgSpeed -value ("{0:N2}" -f ($activity.average_speed * 2.23694))
 	$objActivity | Add-Member -type NoteProperty -name MaxSpeed -value ("{0:N2}" -f($activity.max_speed * 2.23694))
	$objActivity | Add-Member -type NoteProperty -name AvgWatts -value $activity.average_watts
	$objActivity | Add-Member -type NoteProperty -name Elevation -value ("{0:N0}" -f ($activity.total_elevation_gain * 3.28084))
	
	$activities += $objActivity
}


return $activities
