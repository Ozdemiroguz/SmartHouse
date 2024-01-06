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


var rooms = [
    { roomId: 1, roomName: "Mutfak", roomDesc: "Mutfak verileri için tıklayınız" },
    { roomId: 2, roomName: "Salon", roomDesc: "Salon verileri için tıklayınız" },
    { roomId: 3, roomName: "Yatak Odası", roomDesc: "Yatak odası verileri için tıklayınız" },
    { roomId: 4, roomName: "Çocuk Odası", roomDesc: "Çocuk odası verileri için tıklayınız" },
    { roomId: 5, roomName: "Banyo", roomDesc: "Banyo verileri için tıklayınız" },
    { roomId: 6, roomName: "Çalışma odası", roomDesc: "Çalışma odasıverileri için tıklayınız" },
    { roomId: 7, roomName: "Misafir odası", roomDesc: "Misafir odası verileri için tıklayınız" },
]
function loadContent() {
    fetchWeather() 
    loadUserLocally()
    loadUserFromServer()
    console.log(currentUser)
    createRoom() 
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
//createRoomContainers();

function createRoom() {
    var blueContainer = document.getElementById("blueContainer")
    rooms.forEach(function (room) {
        let roomBox = document.getElementById("roomBox").cloneNode(true);
        roomBox.style.display = "inline-block";
        roomBox.children[0].innerText = room.roomName
        roomBox.children[1].innerText = room.roomDesc
        blueContainer.append(roomBox)
    });
    //card header -- h1
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
