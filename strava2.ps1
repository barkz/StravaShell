

Write-Host "Stava User"
$headers = @{
    Authorization = 'Bearer c72642e1afdd278cb01a6f93b4539aaf75a19de8'
}

$response = Invoke-RestMethod -Uri 'https://www.strava.com/api/v3/athlete' -Headers $headers -Method Get
$response

# Function to get all activities with pagination
function Get-AllActivities {
    $page = 1
    $perPage = 30
    $allActivities = @()

    do {
        $uri = "https://www.strava.com/api/v3/athlete/activities"#?page=$page&per_page=$perPage"
        $response = Invoke-RestMethod -Uri $uri -Headers $headers -Method Get
        $allActivities += $response
        $page++
    } while ($response.Count -gt 0)

    return $allActivities
}

# Get all activities
$activities = Get-AllActivities

Write-Host "Strava Activities"
foreach ($activity in $activities) {
    Write-Host $activity.name

    # Uncomment and use the following code to create custom objects if needed
    # $objActivity = New-Object System.Object
    # $objActivity | Add-Member -type NoteProperty -name Date -value $activity.start_date.substring(0,10)
    # $objActivity | Add-Member -type NoteProperty -name Distance -value ("{0:N1}" -f ($activity.distance * 0.00062137))
    # $ts = [timespan]::fromseconds($activity.moving_time)
    # $objActivity | Add-Member -type NoteProperty -name Time -value $ts.ToString("hh\:mm\:ss")
    # $objActivity | Add-Member -type NoteProperty -name AvgSpeed -value ("{0:N2}" -f ($activity.average_speed * 2.23694))
    # $objActivity | Add-Member -type NoteProperty -name MaxSpeed -value ("{0:N2}" -f($activity.max_speed * 2.23694))
    # $objActivity | Add-Member -type NoteProperty -name AvgWatts -value $activity.average_watts
    # $objActivity | Add-Member -type NoteProperty -name Elevation -value ("{0:N0}" -f ($activity.total_elevation_gain * 3.28084))
    # $activities += $objActivity
}

# Optionally, return or process the activities array
# return $activities



