
var user = {
    email: "",
    password: "",
    name: "",
    surname: "",
    phone: "",
    numberOfRooms: 0,
    active: 0
};

document.getElementById("signUpForm").addEventListener("submit", kayitOl);
async function kayitOl(event) {
    event.preventDefault(); // Formun varsayılan davranışını engelle

    // Formdaki değerleri al
    user.name = document.getElementById("ad").value;
    user.surname = document.getElementById("soyAd").value;
    user.email = document.getElementById("email").value;
    user.password = document.getElementById("passWord").value;
    user.phone = document.getElementById("phone").value;
    var confirmPassWord = document.getElementById("passwordd").value;

    console.log(user);
    /*var ad = document.getElementById("ad").value;
    var soyAd = document.getElementById("soyAd").value;
    var email = document.getElementById("email").value;
    var phone = document.getElementById("phone").value;
    var password = document.getElementById("passWord").value;
    var confirmPassWord = document.getElementById("passwordd").value;
    var nrooms = 0;
    var active = 0;
*/
    // Burada diğer gerekli kontrolleri ekleyebilirsiniz, örneğin şifre güvenlik kontrolleri***
    // Şifrelerin eşleşip eşleşmediğini kontrol et
    if (user.password !== confirmPassWord) {
        alert("Şifreler uyuşmuyor!");
        return;
    }
    // POST isteği için veri objesini oluştur

    try {
        const response = await fetch('https://nodejs-mysql-api-sand.vercel.app/api/v1/auth/register', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
            },
            body: JSON.stringify(user),
        });

        const result = await response.json();

        if (response.ok) {
            console.log('Durum mesajı', result);
            if (result.message == "Registration successful") {
                alert("Kayıt başarılı");
                window.location.href = "signin.html";
            }
        } else {
            console.error('Kullanıcı kaydedilirken bir hata oluştu:', result);
        }
    } catch (error) {
        console.error('Error:', error);
        document.getElementById('result').innerText = 'An error occurred.';
    }
};




function kayitTamamla() {
    var name = document.getElementById('ad').value;
    var surname = document.getElementById('soyAd').value;
    var email = document.getElementById('email').value;
    var password = document.getElementById('passWord').value;
    var nrooms = document.getElementById('odaSayisi').value;
    // Kullanıcı bilgilerini localStorage'e kaydet
    localStorage.setItem('ad', name);
    localStorage.setItem('soyAd', surname);
    localStorage.setItem('email', email);
    localStorage.setItem('pasWord', password);
    localStorage.setItem('odaSayisi', nrooms)
    // Bir sonraki sayfaya yönlendir
    window.location.href = 'main.html';
}

function getOptionValue() {
    console.log("getOptionValue function is called");
    var select = document.getElementById("odaSayisi");
    var selectedValue = select.options[select.selectedIndex].value;
    console.log(selectedValue)
    var radioContainer = document.getElementById("radioContainer");
    radioContainer.innerHTML = ''; // Önceki radio butonlarını temizle
    for (var i = 1; i <= selectedValue; i++) {
        // Create a new select element
        var dropdown = document.createElement("select");

        // Set a unique ID for each dropdown
        dropdown.id = "dropdown" + i;

        // Add options to the dropdown
        dropdown.innerHTML = `
        <option value="apartment${i}">Room ${i}</option>
        <option value="house${i}">Mutfak ${i}</option>
        <option value="condo${i}">OturmaOdası ${i}</option>
        <option value="apartment${i}">Yatak Odası ${i}</option>
        <option value="house${i}">Çocuk Odası ${i}</option>
        <option value="condo${i}">Çalışma Odası ${i}</option>
        `;

        // Append the dropdown to the container
        document.getElementById("form").appendChild(dropdown);
    }
}

