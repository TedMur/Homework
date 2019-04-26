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






// Select the submit button
//var submit = d3.select("submit")
//submit.on("click", function(){
//    
//    // Select the input element and get the raw HTML node
//    var inputElement = d3.select("input");
//    
//    // Get the value property of the input element
//    var inputValue = inputElement.property("value");
//    
//    console.log(inputValue);
//    console.log(tableData);   
    
//    var filterData = tableData.filter(tData => tableData.datetime === inputValue);
//    
//    console.log(filterData);
////    
//    var date = filterData.map(tData => tData.time)
//    
//    var datetime:,
//    var city:,
//    var state:,
//    var country:,
//    var shape:,
//    var durationMinutes:,
//    var comments:, 
//    
//    
//    d3.select("")
//      .append("td").text(`${datetime}`)
//      .append("td").text(`${city}`)
//      .append("td").text(`${state}`)
//      .append("td").text(`${country}`)
//      .append("td").text(`${shape}`)
//      .append("td").text(`${durationMinutes}`)
//      .append("td").text(`${comments}`);   
//})