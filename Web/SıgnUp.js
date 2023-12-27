
function kayitTamamla() 
{
    var name = document.getElementById('ad').value;
    var surname = document.getElementById('soyAd').value;
    var email = document.getElementById('email').value;
    var password = document.getElementById('passWord').value;
    var nrooms = document.getElementById('odaSayisi').value;
    // Kullanıcı bilgilerini localStorage'e kaydet
    localStorage.setItem('ad',name);
    localStorage.setItem('soyAd', surname);
    localStorage.setItem('email',email);
    localStorage.setItem('pasWord',password);
    localStorage.setItem('odaSayisi',nrooms)
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