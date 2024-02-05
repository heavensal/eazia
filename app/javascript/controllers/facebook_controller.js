import { Controller } from "@hotwired/stimulus"

export default class extends Controller {

  static targets = ['user']

  connect() {
    console.log('Facebook stimulus connecté');
    this.loadFacebookSDK();
    this.checkLoginState = this.checkLoginState.bind(this); // S'assurer que `this` se réfère à la classe dans `checkLoginState`
  }

  loadFacebookSDK() {
    window.fbAsyncInit = () => {
      FB.init({
        appId      : "598892545759939", // Utilise des métadonnées ou une autre approche pour sécuriser ton App ID
        cookie     : true,
        xfbml      : true,
        version    : 'v19.0'
      });

      FB.AppEvents.logPageView();

      FB.getLoginStatus((response) => {
        this.statusChangeCallback(response);
      });
    };

    (function(d, s, id){
        var js, fjs = d.getElementsByTagName(s)[0];
        if (d.getElementById(id)) return;
        js = d.createElement(s);
        js.id = id;
        js.src = "https://connect.facebook.net/fr_FR/sdk.js";
        fjs.parentNode.insertBefore(js, fjs);
      }
    (document, 'script', 'facebook-jssdk'));
  }

  statusChangeCallback(response) {
    console.log('statusChangeCallback');
    console.log(response);
    if (response.status === 'connected') {
      this.fetchUserInfo();
    }
  }

  fetchUserInfo() {
    FB.api('/me', {fields: 'name'}, (response) => {
      console.log('personne connectée: ' + response.name);
      let userInfo = `Nom: ${response.name}<br>Token d'accès: ${FB.getAuthResponse().accessToken}`;
      this.userTarget.innerHTML = userInfo;
    });
  }

  checkLoginState() {
    FB.login((response) => {
      this.statusChangeCallback(response);
    }, {scope: 'email,public_profile'});
  }
}
