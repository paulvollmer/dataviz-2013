$(document).ready(function() {

    var w = 400;
    var h = 400;




    rawMigrationData_men = [
        ["Daenemark", "m", "an", "n", 1610, 1426, 1500, 1483, 1431, 1514, 1710, 1761, 1792, 1942],
        ["Schweden", "m", "an", "n", 1786, 1799, 1846, 1711, 1729, 1745, 1638, 1821, 1832, 2016],
        ["Finnland", "m", "an", "n", 925, 938, 1001, 260, 225, 1021, 879, 976, 1008, 1102],
        ["Estland", "m", "an", "o", 0, 0, 0, 0, 0, 232, 237, 429, 622, 759],
        ["Lettland", "m", "an", "o", 0, 0, 0, 0, 0, 744, 1077, 3032, 5095, 6531],
        ["Litauen", "m", "an", "o", 0, 0, 0, 0, 0, 1526, 1442, 2162, 3261, 5588],
        ["Polen", "m", "an", "o", 0, 0, 0, 0, 0, 104035, 86302, 81392, 83065, 114832],
        ["Tschechische_Republik", "m", "an", "o", 0, 0, 0, 0, 0, 3556, 3751, 3702, 3821, 5324],
        ["Slowakei", "m", "an", "o", 0, 0, 0, 0, 0, 6034, 5674, 5264, 5396, 7590],
        ["Ungarn", "m", "an", "o", 0, 0, 0, 0, 0, 17714, 19722, 19591, 22681, 31059],
        ["Rumaenien", "m", "an", "o", 0, 0, 0, 0, 0, 26270, 29661, 33993, 45625, 59032],
        ["Bulgarien", "m", "an", "o", 0, 0, 0, 0, 0, 11359, 14480, 17786, 25091, 33709],
        ["Zypern", "m", "an", "o", 0, 0, 0, 0, 0, 165, 152, 212, 221, 278],
        ["Griechenland", "m", "an", "s", 9959, 7904, 6585, 5915, 5458, 5396, 5448, 5805, 8187, 14896],
        ["Slowenien", "m", "an", "s", 0, 0, 0, 0, 0, 792, 852, 1069, 1350, 2498],
        ["Oesterreich", "m", "an", "s", 8193, 7593, 7695, 7622, 8159, 8776, 9197, 9671, 9964, 10171],
        ["Italien", "m", "an", "s", 16499, 14166, 12693, 12031, 11886, 12248, 13362, 14901, 16718, 20001],
        ["Malta", "m", "an", "s", 0, 0, 0, 0, 0, 91, 87, 81, 151, 168],
        ["Spanien", "m", "an", "w", 8089, 7830, 7605, 7536, 7491, 8287, 9330, 10871, 11676, 15813],
        ["Portugal", "m", "an", "w", 6042, 5182, 3941, 3577, 3612, 4056, 4359, 5173, 4990, 6088],
        ["Frankreich", "m", "an", "w", 9826, 9477, 9701, 971, 855, 10339, 10490, 10604, 10635, 10994],
        ["Luxemburg", "m", "an", "w", 957, 974, 1122, 1276, 1435, 1721, 1812, 1642, 1543, 1584],
        ["Belgien", "m", "an", "w", 2477, 2447, 2493, 2385, 2257, 2344, 2431, 2516, 2794, 2983],
        ["Niederlande", "m", "an", "w", 8053, 7447, 7589, 8096, 8151, 8184, 8398, 7491, 7307, 7525],
        ["Vereinigtes_Koenigreich", "m", "an", "w", 8372, 7536, 7278, 7226, 7336, 7486, 8606, 8925, 9329, 9993],
        ["Irland", "m", "an", "w", 1174, 1060, 853, 806, 960, 1060, 1191, 1308, 1313, 1580]
    ];


    migrationData = generateClearJSON(rawMigrationData_men);

    var svg = d3.select("#chartWrapper").append('svg').attr('width', w).attr('height', h);
    var group = svg.append("g.geoPolar");

    var arc = d3.svg.arc()
            .startAngle(function(d) {
        return d.startAngle;
    })
            .endAngle(function(d) {
        return d.endAngle;
    })
            .innerRadius(20)
            .outerRadius(100);

});


// this function generates a better structured json array to work with
function generateClearJSON(data) {

    var returnJSON = [];
    for (i = 0; i < data.length; i++) {
        var yearValues = [];
        for (j = 0; j < 10; j++) {
            yearValues[j] = data[i][j + 4];
        }
        var country = {
            name: "",
            years: [],
            direction: ""
        };

        country.name = data[i][0];
        country.years = yearValues;
        country.direction = data[i][3];

        returnJSON.push(country);
    }
    console.log(returnJSON);
}