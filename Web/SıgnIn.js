function githubLogin() {
    const client_id = '4093b88e1fcd28532c8a'; // GitHub Developer Portal'dan alacağınız client ID
    const redirect_uri = 'http://127.0.0.1:5500/main.html'; // GitHub Developer Portal'dan ayarladığınız geri dönüş URL'si
    // GitHub'a yönlendirme için URL oluşturma
    const githubAuthUrl = `https://github.com/login/oauth/authorize?client_id=${client_id}&redirect_uri=${redirect_uri}&scope=user`;

    // Kullanıcıyı GitHub kimlik doğrulama sayfasına yönlendirme
    window.location.replace(githubAuthUrl);
}
function login(){

//
    //kontorllerden sonra
    var userInfo = {
        email: email,
        password: password
    };

    // Convert the object to a JSON string and save it to localStorage
    localStorage.setItem("userInfo", JSON.stringify(userInfo));



}