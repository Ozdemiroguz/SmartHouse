function githubLogin() {
    const client_id = '4093b88e1fcd28532c8a'; // GitHub Developer Portal'dan alacağınız client ID
    const redirect_uri = 'http://127.0.0.1:5500/main.html'; // GitHub Developer Portal'dan ayarladığınız geri dönüş URL'si
    // GitHub'a yönlendirme için URL oluşturma
    const githubAuthUrl = `https://github.com/login/oauth/authorize?client_id=${client_id}&redirect_uri=${redirect_uri}&scope=user`;

    // Kullanıcıyı GitHub kimlik doğrulama sayfasına yönlendirme
    window.location.replace(githubAuthUrl);
}







document.addEventListener('DOMContentLoaded', function () {
    // Sayfa yüklendiğinde kontrol et ve kayıtlı kullanıcı varsa bilgileri doldur
    checkAndPopulateUser();
});
function checkAndPopulateUser() {
    // LocalStorage'tan kullanıcı bilgilerini al
    const emaill = localStorage.getItem('email');
    const passwordd = localStorage.getItem('password');
    if (email && password) {

        const apiUrl = 'https://nodejs-mysql-api-sand.vercel.app/api/v1/auth/login'; // API'nizin gerçek adresiyle değiştirin

        // Bu noktada main.html sayfasına yönlendirme yapabilirsiniz
        const loginData = {
            email: emaill, password: passwordd,
        };
        console.log(loginData);

        // Giriş isteğini gönder
        fetch(apiUrl, {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
            },
            body: JSON.stringify(loginData),
        })
            .then(response => response.json())
            .then(data => {
                if (data.accessToken) {
                    var currentUser = { userId: data.data.userId, email: loginData.email, password: loginData.password }
                    saveUserLocally(currentUser);
                    console.log('Giriş başarılı!');
                    console.log('Access Token:', data.accessToken);
                    console.log('User ID:', data.data.userId);
                    console.log('Name:', data.data.name);
                    console.log('Email:', data.data.email);
                    window.location.href = "main.html";
                    var redirectUrl = 'main.html';
                    // Yönlendirme işlemi
                    window.location.href = redirectUrl;
                }
                //if(data.data.userId=="33"){

                //}
                else {
                    console.error('Giriş başarısız:', data.error);
                }
            })
            .catch(error => {
                console.error('İstek hatası:', error);
            });

    }
}




function login() {
    //kontorllerden sonra
    var userInfo = {
        email: email,
        password: password
    };
    // Convert the object to a JSON string and save it to localStorage
    localStorage.setItem("userInfo", JSON.stringify(userInfo));
}

document.getElementById("signInForm").addEventListener("submit", login);

async function login(event) {

    event.preventDefault(); // Formun varsayılan davranışını engelle
    const apiUrl = 'https://nodejs-mysql-api-sand.vercel.app/api/v1/auth/login'; // API'nizin gerçek adresiyle değiştirin
    // Kullanıcı girişi için örnek veri
    const loginData = {
        email: document.getElementById("email").value, password: document.getElementById("password").value,
    };
    console.log(loginData);

    // Giriş isteğini gönder
    fetch(apiUrl, {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json',
        },
        body: JSON.stringify(loginData),
    })
        .then(response => response.json())
        .then(data => {
            if (data.accessToken) {
                var currentUser = { userId: data.data.userId, email: loginData.email, password: loginData.password }
                saveUserLocally(currentUser);
                console.log('Giriş başarılı!');
                console.log('Access Token:', data.accessToken);
                console.log('User ID:', data.data.userId);
                console.log('Name:', data.data.name);
                console.log('Email:', data.data.email);
                window.location.href = "main.html";
                var redirectUrl = 'main.html';
                // Yönlendirme işlemi
                window.location.href = redirectUrl;
            }
            //if(data.data.userId=="33"){

            //}
            else {
                console.error('Giriş başarısız:', data.error);
            }
        })
        .catch(error => {
            console.error('İstek hatası:', error);
        });

}
// Kullanıcı girişi yapma fonksiyonu


// Kullanıcıyı kaydetme fonksiyonu
function saveUserLocally(currentUser) {
    if (currentUser) {
        // Kullanıcı bilgilerini yerel depolamaya kaydet
        localStorage.setItem('currentUser', JSON.stringify(currentUser));
        localStorage.setItem('email', currentUser.email);
        localStorage.setItem('password', currentUser.password);

        console.log('User saved locally:', currentUser);
    } else {
        console.error('No user logged in.');
    }
}

// Kullanıcıyı yerel depodan yükleme fonksiyonu
function loadUserLocally() {
    const storedUser = localStorage.getItem('currentUser');
    if (storedUser) {
        currentUser = JSON.parse(storedUser);
        console.log('User loaded from local storage:', currentUser);
    } else {
        localStorage.setItem()
    }
}


function validateForm() {
    var email = document.getElementById('email').value;
    var emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
    if (!emailRegex.test(email)) {
        alert("Please enter a valid email address.");
        return false; // prevent form submission
    }
    // Continue with form submission if email is valid
    return true;
}



// Örnek kullanıcı girişi
//loginUser('ozdemiroguzhan55@gmail.com', '123456');

// Kullanıcıyı yerel depolamaya kaydet
//saveUserLocally();

// Kullanıcıyı yerel depodan yükle

// Çağırma örneği
