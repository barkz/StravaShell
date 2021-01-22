
function myFunction() {
    var jsonoutput = '';

    if (this.readyState == 4 && this.status == 200) {
        var json = JSON.parse(this.responseText);
        var count = 0;
        var total_distance = 0;
        console.log(json);
        for (var a in json) {
            count += 1;
            
            jsonoutput += '<tr>';
        
            jsonoutput += '<td>' + json[a].name;
            jsonoutput += '<td>' + json[a].start_date.substring(0, 10);
            jsonoutput += '<td>' + Math.round(json[a].total_elevation_gain * 3.28084) + ' ft';
            jsonoutput += '<td>' + (json[a].average_speed * 2.23694).toFixed(2) + ' mph';
            jsonoutput += '<td>' + (json[a].max_speed * 2.23694).toFixed(2) + ' mph';
            jsonoutput += '<td>' + (json[a].distance * 0.00062137).toFixed(2) + ' mi';
            if (json[a].max_heartrate)
                {
                    jsonoutput += '<td>' + json[a].average_watts;
                } else
                    
                {
                    jsonoutput += '<td>' 
                }
             
            if (json[a].average_heartrate)
                {
                    jsonoutput += '<td>' + json[a].average_heartrate;
                } else
                    
                {
                    jsonoutput += '<td>' 
                }
            
            if (json[a].max_heartrate)
                {
                    jsonoutput += '<td>' + json[a].max_heartrate;
                } else
                    
                {
                    jsonoutput += '<td>' 
                }
            
            
             if (json[a].pr_count > 0)
                {
                    jsonoutput += '<td><span class="badge"><span class="glyphicon glyphicon-king">  ' + json[a].pr_count + '</span></span>';
                } else
                    
                {
                    jsonoutput += '<td>' 
                }
            jsonoutput += '</tr>';

            total_distance += json[a].distance;
        }

        jsonoutput += '<tr><th>Total<th><th><th><th><th><th><th><th>' + (total_distance * 0.00062137).toFixed(2) + '<th></tr>';
        
        var output = document.getElementById('mytable');
        output.insertAdjacentHTML('beforeend', jsonoutput);
        
    }
}

$(document).ready (function(){
    var myRequest = new XMLHttpRequest();
    myRequest.overrideMimeType("application/json");
    myRequest.onreadystatechange = myFunction;
    myRequest.open("GET", "https://www.strava.com/api/v3/activities?access_token=ACCESSTOKENGOESHERE&per_page=50", true);
    myRequest.send(null);
    
});





