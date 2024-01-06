
// app.js
/*var currentUser
document.addEventListener('DOMContentLoaded', function () {
    // Sayfa yüklendiğinde tüm kullanıcıları çek ve listele
    fetchUsers();
});
function openUserInfoModal(userID) {
    // Kullanıcı bilgilerini modal'a doldur
    const userInfoModal = document.getElementById('userInfoModal');
    const userNameInput = document.getElementById('userName');
    const userSurnameInput = document.getElementById('userSurname');
    const userEmailInput = document.getElementById('userEmail');
    const userPasswordInput = document.getElementById('userPassword');
    const userRoomInput = document.getElementById('userRoom');

    // Burada userID'yi kullanarak API'den ilgili kullanıcı bilgilerini çekebilirsiniz
    // Ve bu bilgileri modal üzerinde gösterirsiniz

    // Örneğin, bu örnekte userID'yi kullanarak bir kullanıcının bilgilerini çekmek için ayrı bir API çağrısı yapmamız gerekiyor.
    // Bu işlemi yaparken fetch kullanılabilir.

    fetch(`http://localhost:3000/kullanici/${userID}`)
        .then(response => response.json())
        .then(userData => {
            currentUser = userData;
            // Modal içindeki inputlara değerleri yerleştir
            userNameInput.value = userData.Name;
            userSurnameInput.value = userData.Surname;
            userEmailInput.value = userData.Mail;
            userPasswordInput.value = userData.Password;
            userRoomInput.value = userData.NumberOfRooms;
        })
        .catch(error => {
            console.error('Kullanıcı bilgilerini çekerken bir hata oluştu:', error);
        });

    // Modal'ı göster
    userInfoModal.style.display = 'block';
}

function saveUserInfo() {
    // Kullanıcı bilgilerini al
    const userId = currentUser && currentUser.UserID;
    const name = document.getElementById('userName').value;
    const surname = document.getElementById('userSurname').value;
    const email = document.getElementById('userEmail').value;
    const password = document.getElementById('userPassword').value;
    const phone = "5454542532";
    const numberOfRooms = document.getElementById('userRoom').value;
    const active = 1;

    // API endpoint'i
    const apiUrl = `http://localhost:3000/kullanici-guncelle/${userId}`;

    // Kullanıcı bilgilerini güncellemek için fetch kullan
    fetch(apiUrl, {
        method: 'POST', // POST metodu kullanıldı
        headers: {
            'Content-Type': 'application/json'
        },
        body: JSON.stringify({
            name: name,
            surname: surname,
            email: email,
            password: password,
            phone: phone,
            numberOfRooms: numberOfRooms,
            active: active
        })
    })
        .then(response => {
            if (!response.ok) {
                throw new Error('API isteğinde bir hata oluştu');
            }
            return response.json();
        })
        .then(data => {
            console.log('Kullanıcı bilgileri başarıyla güncellendi:', data);
            // Kullanıcı bilgileri başarıyla güncellendiğinde yapılacak işlemleri buraya ekleyebilirsiniz.
        })
        .catch(error => {
            console.error('Kullanıcı bilgilerini güncellerken bir hata oluştu:', error);
        });

    console.log('Kullanıcı bilgileri kaydedildi.');
    closeUserInfo();
}

function closeUserInfo() {
    // Modal'ı kapat
    const userInfoModal = document.getElementById('userInfoModal');
    userInfoModal.style.display = 'none';
}
*/
// API'nin temel URL'sini buraya ekleyin
var currentUserId;

const apiUrl = 'https://nodejs-mysql-api-sand.vercel.app/api/v1/user';
// API'nizin gerçek adresiyle değiştirin

//Tüm kullanıcıları getir

// Tüm kullanıcıları getir

// Belirli bir kullanıcıyı ID'ye göre getir


// Yeni bir kullanıcı oluştur
/*const newUserData = {
    mail: 'yeni@mail.com',
    name: 'Yeni',
    surname: 'Kullanıcı',
    password: 'sifre123',
    phone: '123456789',
    numberOfRooms: 2,
    active: true,
};

fetch(apiUrl, {
    method: 'POST',
    headers: {
        'Content-Type': 'application/json',
    },
    body: JSON.stringify(newUserData),
})
    .then(response => response.json())
    .then(data => {
        console.log('Yeni kullanıcı oluşturuldu:', data.data);
    })
    .catch(error => {
        console.error('Kullanıcı oluşturma hatası:', error);
    });
*/





// Tüm kullanıcıları getir




// Tüm kullanıcıları getir
document.addEventListener('DOMContentLoaded', function () {
    // Sayfa yüklendiğinde tüm kullanıcıları çek ve listele
    fetchUsers();
});


async function fetchUsers() {
    const userListElement = document.getElementById('userList');

    fetch(apiUrl)
        .then(response => response.json())
        .then(data => {
            console.log('Tüm kullanıcılar:', data.data);
            data.data.forEach(user => {
                const userItem = document.createElement('div');
                userItem.classList.add('user-item');
                userItem.dataset.userid = user.UserID;
                userItem.id = user.UserID
                // Kullanıcı kimliğini veri özelliğine ekle
                userItem.innerHTML = `
                    <div>Name: ${user.Name}, Surname: ${user.Surname}, Email: ${user.Mail}, Password:*********, Number of Room: ${user.NumberOfRooms}, Active:${user.Active}<span class="user-status online"></span></div>
                    <i class="fa-solid fa-gear" onclick="openUserInfoModal(${user.UserID})"></i>
                    <i class="fa-solid fa-house "onclick="openRooms(${user.UserID})"></i>
                    <i class="fa-solid fa-house "onclick="openRoomInfoModal(${user.UserID})">+</i>

                    <button class="delete-user-button" onclick="deleteUser(${user.UserID})">Delete User</button>
                `;
                userListElement.appendChild(userItem);
            });
        })
        .catch(error => {
            console.error('Veri çekme hatası:', error);
        });
}
function deleteUser(userID) {
    //silme işlemi için confirm kullan
    if (!confirm('Kullanıcıyı silmek istediğinizden emin misiniz?')) {
        return;
    }

    fetch(`${apiUrl}/${userID}`, {
        method: 'DELETE',
    })
        .then(response => response.json())
        .then(data => {
            console.log('Kullanıcı silindi:', data.data);
            //KULLANICI SİLİNDİ MESAJI GÖSTER
            alert("Kullanıcı silindi");
            //SAyfa yenile  
            window.location.reload();
        })
        .catch(error => {
            console.error('Kullanıcı silme hatası:', error);
        });
}
function openUserInfoModal(userID) {
    //modalı aç
    const userInfoModal = document.getElementById('userInfoModal');
    userInfoModal.style.display = 'block';

    // Kullanıcı bilgilerini modal'a doldur
    const userNameInput = document.getElementById('userName');
    const userSurnameInput = document.getElementById('userSurname');
    const userEmailInput = document.getElementById('userEmail');
    const userRoomInput = document.getElementById('userRoom');
    const userActiveInput = document.getElementById('userActive');
    const userPhoneInput = document.getElementById('userPhone');
    
   
    // Burada userID'yi kullanarak API'den ilgili kullanıcı bilgilerini çekebilirsiniz
    //fetcth ile kullanıcı bilgilerini çek
    // İsteğe bağlı olarak istediğiniz kullanıcının ID'sini belirtin
    fetch(`${apiUrl}/${userID}`)
        .then(response => response.json())
        .then(data => {
            currentUserId = data.data[0].UserID;
            // Modal içindeki inputlara değerleri yerleştir
            userNameInput.value = data.data[0].Name;
            userSurnameInput.value = data.data[0].Surname;
            userEmailInput.value = data.data[0].Mail;
            userRoomInput.value = data.data[0].NumberOfRooms;
            userActiveInput.value = data.data[0].Active;
            userPhoneInput.value = data.data[0].Phone;


            console.log('Belirli kullanıcı:', data.data);
        })
        .catch(error => {
            console.error('Veri çekme hatası:', error);
        });
       
    
}
// Kullanıcı bilgilerini güncelle
function saveUserInfo() {
    //modaldaki verileri al
    //confirm kullan
    //bilgilerin değişip değişmediğini kontrol et
    if (!confirm('Kullanıcı bilgilerini güncellemek istediğinizden emin misiniz?')) {
        return;
    }
    // Belirli bir kullanıcıyı güncelle
    const updatedUserData = {
        mail: document.getElementById('userEmail').value,
        name: document.getElementById('userName').value,
        surname: document.getElementById('userSurname').value,
        phone: document.getElementById('userPhone').value,
        numberOfRooms: document.getElementById('userRoom').value,
        active: document.getElementById('userActive').value,
    };
    fetch(`${apiUrl}/updateUser/${currentUserId}`, {
        method: 'PUT',
        headers: {
            'Content-Type': 'application/json',
        },
        body: JSON.stringify(updatedUserData),
    })
        .then(response => response.json())
        .then(data => {
            console.log('Kullanıcı güncellendi:', data.data);
        })
        .catch(error => {
            console.error('Kullanıcı güncelleme hatası:', error);
        });

    //alert mesajı göster   
    alert("Kullanıcı bilgileri güncellendi");
    //sayfayı yenile
    window.location.reload();
    //
}
function addUser() {
    // Kullanıcı bilgilerini modal'a doldur
    const userNameInput = document.getElementById('userName');
    const userSurnameInput = document.getElementById('userSurname');
    const userEmailInput = document.getElementById('userEmail');
    const userRoomInput = document.getElementById('userRoom');
    const userActiveInput = document.getElementById('userActive');
    const userPhoneInput = document.getElementById('userPhone');
    const userPasswordInput = document.getElementById('password');

    const newUserData = {
        mail: userEmailInput.value,
        name: userNameInput.value,
        surname: userSurnameInput.value,
        password: userPasswordInput.value,
        phone: userPhoneInput.value,
        numberOfRooms: userRoomInput.value,
        active: userActiveInput.value,
    };

    fetch(apiUrl, {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json',
        },
        body: JSON.stringify(newUserData),
    })
        .then(response => response.json())
        .then(data => {
            //kontrol et
            if (data.status == "error") {
                console.error('Kullanıcı oluşturma hatası:', data);

                alert("Kullanıcı eklenemedi");
                return;
            }
            console.log('Kullanıcı oluşturuldu:', data.status);
            //Kullanıcı eklendi mesajı göster
            alert("Kullanıcı eklendi");
            //sayfayı yenile
        })
        .catch(error => {
            console.error('Kullanıcı oluşturma hatası:', error);
        });


}
function openUserInfoModalAddUser() {
    //modal üstü yazıyı değiştir
    const modalTitle = document.getElementById('modalTitle');
    console.log(modalTitle);
    modalTitle.innerHTML = "Kullanıcı Ekle";
    const userNameInput = document.getElementById('userName');
    const userSurnameInput = document.getElementById('userSurname');
    const userEmailInput = document.getElementById('userEmail');
    const userRoomInput = document.getElementById('userRoom');
    const userActiveInput = document.getElementById('userActive');
    const userPhoneInput = document.getElementById('userPhone');
    const userInfoModal = document.getElementById('userInfoModal');
    userInfoModal.style.display = 'block';
    const userPasswordInput = document.getElementById('password');
    userPasswordInput.style.display = 'block';

    //input değerlerini boşalt
    userNameInput.value = "";
    userSurnameInput.value = "";
    userEmailInput.value = "";
    userRoomInput.value = "";
    userActiveInput.value = "";
    userPhoneInput.value = "";
    userPasswordInput.value = "";

    //save buttona addUser fonksiyonunu ekle
    const saveButton = document.getElementById('saveButton');
    saveButton.onclick = addUser;

}
function openRooms(userID) {
    console.log(userID);
    //fetch rooms
    const roomsUrl = 'https://nodejs-mysql-api-sand.vercel.app/api/v1/room';
    fetch(`${roomsUrl}/${userID}/rooms`, {
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
            const roomsList = document.getElementById('roomsList');
            //room liste başlık ooluştur
            if (data.data.length == 0) {
                alert("Kullanıcının odası bulunmamaktadır");
                return;
            }
            data.data.forEach(room => {
                const roomItem = document.createElement('div');
                roomItem.classList.add('room-item');
                roomItem.dataset.roomid = room.RoomID; // Kullanıcı kimliğini veri özelliğine ekle
                roomItem.innerHTML = `
                    <div>RoomID: ${room.RoomID}, Room Name: ${room.RoomName}, Room Status:${room.RoomStatus}<span class="user-status online"></span></div>
                    <i class="fa-solid fa-gear" onclick="openRoomInfoModal(${room.RoomID})"></i>
                    <button class="delete-room-button" onclick="deleteRoom(${room.RoomID})">Delete Room</button>
                `;
                console.log(roomItem);
                document.getElementById('roomList').appendChild(roomItem);
            });
        })
        .catch(error => {
            console.error('Oda bilgilerini alma hatası:', error);
        });

}
function openRoomInfoModal(userId) {
    //modalı aç
    const roomInfoModal = document.getElementById('roomInfoModal');
    roomInfoModal.style.display = 'block';
    currentUserId = userId;
    // Kullanıcı bilgilerini modal'a doldur
    // Burada userID'yi kullanarak API'den ilgili kullanıcı bilgilerini çekebilirsiniz
    //fetcth ile kullanıcı bilgilerini çek
    // İsteğe bağlı olarak istediğiniz kullanıcının ID'sini belirtin
}
function closeRoomInfo() {
    // Modal'ı kapat
    const roomInfoModal = document.getElementById('roomInfoModal');
    roomInfoModal.style.display = 'none';
}
function addRoom() {
    // Kullanıcı bilgilerini modal'a doldur
    console.log(currentUserId);
    const roomNameInput = document.getElementById('roomName');
    const optimumTemperatureInput = document.getElementById('optimumTemperature');
    const optimumHumidityInput = document.getElementById('optimumHumidity');
    const optimumGaseInput = document.getElementById('optimumGase');
    const roomTypeInput = document.getElementById('roomType');


    //verileri  kontrol et
    if (roomNameInput.value == "" || optimumTemperatureInput.value == "" || optimumHumidityInput.value == "" || optimumGaseInput.value == "" || roomTypeInput.value == "") {
        alert("Lütfen tüm alanları doldurunuz");
        return;
    }

    const newRoomData = {
        roomName: roomNameInput.value,
        optimumTemperature: optimumTemperatureInput.value,
        optimumHumidity: optimumHumidityInput.value,
        optimumGase: optimumGaseInput.value,
        roomType: roomTypeInput.value,
    };
    //fetch try catch ile
    fetch(`https://nodejs-mysql-api-sand.vercel.app/api/v1/room/${currentUserId}/rooms`, {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json',
        },
        body: JSON.stringify(newRoomData),
    })
        .then(response => response.json())
        .then(data => {
            //kontrol et
            if (data.status == "error") {
                console.error('Oda oluşturma hatası:', data);

                alert("Oda eklenemedi");
                return;
            }
            console.log('Oda oluşturuldu:', data.status);
            //Kullanıcı eklendi mesajı göster
            alert("Oda eklendi");
            //sayfayı yenile
        })
        .catch(error => {
            console.error('Oda oluşturma hatası:', error);
        });

}
