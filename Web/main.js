var person = { ad: "", soyAd: "", kullanıcıAd: "", password: "", odaSayisi:"" };
let weatherData = {};
const city = document.getElementById("city");
const temp = document.getElementById("temp");
const humidity =  document.getElementById("humidity");
const feels_like = document.getElementById("feels_like");
window.addEventListener("DOMContentLoaded", loadContent)

var rooms=[
    {roomId:1,roomName:"Mutfak",roomDesc:"Mutfak verileri için tıklayınız"},
    {roomId:2,roomName:"Salon",roomDesc:"Salon verileri için tıklayınız"},
    {roomId:3,roomName:"Yatak Odası",roomDesc:"Yatak odası verileri için tıklayınız"},
    {roomId:4,roomName:"Çocuk Odası",roomDesc:"Çocuk odası verileri için tıklayınız"},
    {roomId:5,roomName:"Banyo",roomDesc:"Banyo verileri için tıklayınız"},
    {roomId:6,roomName:"Çalışma odası",roomDesc:"Çalışma odasıverileri için tıklayınız"},
    {roomId:7,roomName:"Misafir odası",roomDesc:"Misafir odası verileri için tıklayınız"},
]
function loadContent(){
    fetchWeather()
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
var userInfoElement = document.getElementById('userInfo');
userInfoElement.innerHTML = 'Name : ' + name + '<br>' +'Surname:'+ surname +'<br>' +'e-mail : ' + email + '<br>' + 'Room  :'+ nrooms;

function createRoomContainers() {
        // Get the "blue-container" element
        var blueContainer = document.querySelector('.blue-container');
        // Adding 2 to nrooms and storing it in a new variable
        var newNrooms = parseInt(nrooms);
        // Clear existing containers
      // blueContainer.innerHTML = '';
        // Create containers based on the selected room count
        for (var i = 0; i < newNrooms; i++) {
            var roomContainer = document.createElement('div');
            roomContainer.className = 'box';
            roomContainer.innerText = 'Room ' + (i + 1);
            blueContainer.appendChild(roomContainer);
        }
    }
createRoomContainers();
function createRoom()
{
var blueContainer=document.getElementById("blueContainer")
    rooms.forEach(function (room) {
        let roomBox = document.getElementById("roomBox").cloneNode(true);
        roomBox.style.display = "inline-block";
        roomBox.children[0].innerText=room.roomName
        roomBox.children[1].innerText=room.roomDesc
        blueContainer.append(roomBox)
    });
    //card header -- h1
}