currentUser = {
    ID: 0,
    mail: "",
    name: "",
    surname: "",
    phone: "",
    numberOfRooms: 0,
    active: 0
};
let weatherData = {};
const city = document.getElementById("city");
const temp = document.getElementById("temp");
const humidity =  document.getElementById("humidity");
const feels_like = document.getElementById("feels_like");
window.addEventListener("DOMContentLoaded", loadContent)


/*var rooms = [
    { roomId: 1, roomName: "Mutfak", roomDesc: "Mutfak verileri için tıklayınız" },
    { roomId: 2, roomName: "Salon", roomDesc: "Salon verileri için tıklayınız" },
    { roomId: 3, roomName: "Yatak Odası", roomDesc: "Yatak odası verileri için tıklayınız" },
    { roomId: 4, roomName: "Çocuk Odası", roomDesc: "Çocuk odası verileri için tıklayınız" },
    { roomId: 5, roomName: "Banyo", roomDesc: "Banyo verileri için tıklayınız" },
    { roomId: 6, roomName: "Çalışma odası", roomDesc: "Çalışma odasıverileri için tıklayınız" },
    { roomId: 7, roomName: "Misafir odası", roomDesc: "Misafir odası verileri için tıklayınız" },
]*/
function loadContent() {
    fetchWeather() 
    loadUserLocally()
    loadUserFromServer()
    console.log(currentUser)
    createRoom() 
    GetTemperature()
}

function fetchWeather(){
    const url ="https://api.openweathermap.org/data/2.5/weather?q=Istanbul&appid=08c51fb1f1565c23c154f933b3230297&units=metric";

    fetch(url).then(res => {
         if(res.ok){
            return res.json();
        }else {
            throw new Error("Yer algılanamadı");
        }
    })
    .then(
        (data) => {
            console.log(data)
            temp.innerText= data.main.temp;
            feels_like.innerText=data.main.feels_like;
            humidity.innerText=data.main.humidity;
            
        }
    )
    .catch((error) => {
        console.error("Hava durumu alınırken hata oluştu:", error);
    });

}
var name = localStorage.getItem('ad');
var surname = localStorage.getItem('soyAd');
var email = localStorage.getItem('email');
var password = localStorage.getItem('passWord');
var nrooms = localStorage.getItem('odaSayisi');
// Kullanıcı bilgilerini görüntüle


/*function createRoomContainers(nrooms) {
    // Get the "blue-container" element
    var blueContainer = document.querySelector('.blue-container');
    ""
    blueContainer.innerHTML = '';
    // Create containers based on the room count
    for (var i = 0; i < nrooms; i++) {
        var roomContainer = document.createElement('div');
        roomContainer.className = 'box';
        roomContainer.innerText = 'Room ' + (i + 1);
        blueContainer.appendChild(roomContainer);
    }
}*/
//createRoomContainers();

function createRoom() {
    const roomsUrl = 'https://nodejs-mysql-api-sand.vercel.app/api/v1/room';
    fetch(`${roomsUrl}/${currentUser.ID}}/rooms`, {
        method: 'GET',
        headers: {
            'Content-Type': 'application/json',
        },
    })
        .then(response => response.json())
        .then(data => {
            console.log('Kullanıcının odaları:', data.data);
            console.log('Tüm odalar:', data);
            //check if user has rooms
            //roomsList divini al
            const roomsList = document.getElementById('roomList');
            //room liste başlık oluştur
            if (data.data.length == 0) {
                alert("Kullanıcının odası bulunmamaktadır");
                return;
            }
            data.data.forEach(room => {
                let roomBox = document.getElementById("roomBox").cloneNode(true);
                roomBox.style.display = "inline-block";
                roomBox.children[0].innerText = room.RoomType
                fetch(`https://nodejs-mysql-api-sand.vercel.app/api/v1/getSensor/getAllLatestSensorReadings?roomID=${roomID}`, {
    method: 'GET',
    headers: {
        'Authorization': 'Bearer YOUR_API_KEY',
        'Content-Type': 'application/json',
    },
})
    .then(response => response.json())
    .then(data => {
        console.log('Getting temperature...');
        console.log(data);
    })
    .catch(error => {
        
        console.error('Error:', error);
    });
                blueContainer.append(roomBox)
            });
        })
        .catch(error => {
            console.error('Oda bilgilerini alma hatası:', error);
        });
}
function loadUserLocally() {
    const storedUser = localStorage.getItem('currentUser');
    if (storedUser) {
        // JSON formatındaki kullanıcı bilgilerini nesneye dönüştürüyoruz
        const tempUser = JSON.parse(storedUser);
        console.log(tempUser)
        currentUser.ID = tempUser.userId;
        currentUser.mail = tempUser.email;
        console.log(currentUser)

        console.log('User loaded from local storage:', currentUser);
    } else {
        // Eğer localStorage'ta kullanıcı bilgisi yoksa, burada set etmelisiniz.
        // Örneğin:
        localStorage.setItem('currentUser', JSON.stringify(currentUser));
    }
}

function loadUserFromServer() {
    const apiUrl = 'https://nodejs-mysql-api-sand.vercel.app/api/v1/user'; // API'nizin gerçek adresiyle değiştirin
    console.log(currentUser.ID)

    fetch(`${apiUrl}/${currentUser.ID}`)
        .then(response => response.json())
        .then(data => {
            //  currentUser = data;
            currentUser.name = data.data[0].Name;
            currentUser.surname = data.data[0].Surname;
            currentUser.phone = data.data[0].Phone;
            currentUser.numberOfRooms = data.data[0].NumberOfRooms;
            currentUser.active = data.data[0].Active;
            console.log(currentUser)
            var userInfoElement = document.getElementById('userInfo');

            userInfoElement.innerHTML = 'Name : ' + currentUser.name + '<br>' + 'Surname:' + currentUser.surname + '<br>' + 'e-mail : ' + currentUser.mail + '<br>' + 'Room  :' + currentUser.numberOfRooms;



            console.log('Belirli kullanıcı:', data.data);
        })
        .catch(error => {
            console.error('Veri çekme hatası:', error);
        });

}
/*var modal = document.getElementById("boxmodal");
var ikons = document.getElementById("blueContainer");
var span =document.getElementsByClassName("close")[0];
ikons.onclick=function(){
    modal.style.display="block";
}
span.onclick=function(){
    modal.style.display="none";
}
window.onclick=function(event){
    if(event.target == modal){
        modal.style.display="none";
    }
}*/
/*
var chartData = [data.main.tempc];
async function GetTemperature() {

    try {
        const response = await fetch(`https://nodejs-mysql-api-sand.vercel.app/api/v1/getSensor/getSensorReadings10?sensorType=Temp_Hum&roomID=${currentUser.ID}`, {
            method: 'GET',
            headers: {
                'Authorization': `Bearer YOUR_API_KEY`, // API anahtarınızı ekleyin
                'Content-Type': 'application/json',
            }
        });

        if (!response.ok) {
            throw new Error('Network response was not ok');
        }

        const data = await response.json();
        console.log(data);

        // API'dan alınan sıcaklık verilerini kullanarak chartData'yi güncelle
        const temps = data.main.tempc; // API'dan alınan sıcaklık değeri
        const d = new Date();
        const hour = d.getHours();
        const minute = d.getMinutes();
        const second = d.getSeconds();
        const temperature = [{ v: [hour, minute, second] }, temp, `color: ${GetColor(temps)}`];

        chartData.push(temperature);
        if (chartData.length === 11) {
            chartData.shift();
        }

        // Grafikleri çiz
        drawBasic();
        drawChart();
    } catch (error) {
        console.error('Error:', error);
    }
}

    
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
}*/
function GetTemperature()
{
    fetch(`https://nodejs-mysql-api-sand.vercel.app/api/v1/getSensor/getAllLatestSensorReadings?roomID=${roomID}`, {
    method: 'GET',
    headers: {
        'Authorization': 'Bearer YOUR_API_KEY',
        'Content-Type': 'application/json',
    },
})
    .then(response => response.json())
    .then(data => {
        console.log('Getting temperature...');
        console.log(data);
    })
    .catch(error => {
        
        console.error('Error:', error);
    });
}