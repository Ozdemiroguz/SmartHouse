var chartData = [];
const options = {

    title: 'Temperature Of The Room',
    hAxis: {
        title: 'Time of Day',
        format: 'H:mm:ss',


    },
    vAxis: {
        title: 'Temperature (scale of 5-30)',
        viewWindow: {
            min: 5,
            max: 30,
        }

    },
    legend: 'none',

};


google.charts.load('current', { packages: ['corechart'] });
google.charts.setOnLoadCallback(drawBasic);
google.charts.setOnLoadCallback(drawChart);
setInterval(function () {
    GetTemperature()
    drawBasic();
    drawChart();
}, 1000); // 10 
setInterval(drawBasic, 1000);


function drawBasic() {

    var data = new google.visualization.DataTable();
    data.addColumn('timeofday', 'Time of Day');
    data.addColumn('number', 'Temprature');
    data.addColumn({ type: 'string', role: 'style' });
    data.addRows(chartData);
    var chart = new google.visualization.ColumnChart(
        document.getElementById('chart_div'));
    chart.draw(data, options);
}
function drawChart() {
    var data = new google.visualization.DataTable();
    data.addColumn('timeofday', 'Time of Day');
    data.addColumn('number', 'Motivation Level');
    data.addColumn({ type: 'string', role: 'style' });

    // İlk veri satırları


    data.addRows(chartData);

    // Grafik seçenekleri


    var chart = new google.visualization.LineChart(document.getElementById('chart_div1'));

    chart.draw(data, options);
}
function GetColor(value) {
    return value < 14 ? "#FDFD04"
        : value < 16 ? "#FBD400"
            : value < 18 ? "#FB9E00"
                : value < 20 ? "#F97C00"
                    : "#FE3F02";
}
function GetTemperature() {
    var min = 120;
    var max = 270;

    var temp = (Math.floor(Math.random() * (max - min + 1) + min)) / 10;
    const d = new Date();
    var hour = d.getHours();
    var minute = d.getMinutes();
    var second = d.getSeconds();
    var temprature = [{ v: [hour, minute, second] }, temp, `color: ${GetColor(temp)}`]
    console.log(temprature);
    chartData.push(temprature);
    if (chartData.length == 11) {
        chartData.shift();

    }
    console.log(chartData);
    console.log(chartData);

}

