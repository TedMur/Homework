// from data.js
var tableData = data;
tbody = d3.select("tbody");


//// using Object.entries to get key, value data inside of the table
//// and loop through them to add to the table in html
//data.forEach(function(ufoReport){
//    console.log(ufoReport);
//    var row = tbody.append("tr");
//    Object.entries(ufoReport).forEach(function([key,value]){
//        console.log(key,value);
//        var cell = tbody.append("td");
//        cell.text(value);
//    })
//});

function displayData(data){ 
    tbody.text("")
    data.forEach(function(sighting){
    new_tr = tbody.append("tr")
    Object.entries(sighting).forEach(function([key, value]){
        new_td = new_tr.append("td").text(value)	
    })
})};

displayData(tableData)

//select the web user's input and the filter button
var filterBtn = d3.select("#filter-btn");
var inputText = d3.select("#datetime");

// filter data with date that the user inputs
function clickSelect() {
    
    //don't refresh the page!
    d3.event.preventDefault();
    
    //print the value that was input
    console.log(inputText.property("value"));
    
    //create a new table showing only the filterd data
    var newTable = tableData.filter(sighting => sighting.datetime === inputText.property("value"));
    
    //display the new table
    displayData(newTable);
    inputText.on("change", clickSelect)
}
