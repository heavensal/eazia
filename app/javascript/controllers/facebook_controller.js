import { Controller } from "@hotwired/stimulus"


// PLUSIEURS ETAPES DANS LA CONNEXION VERS FACEBOOK
// 1. On charge le SDK Facebook
// 2. On demande à l'utilisateur de se connecter
// 3. On choisit les permissions à demander
// 4. On choisit pour quelle page on demande les permissions
// 5. Possiblement, on choisit le instagram liée à la page
// 6. On récupère le token
// 7. On met à jour le token dans la base de données
// 8. On met a jour le button de connexion car on est bien connecté

export default class extends Controller {

  static targets = ['user', 'button']

  connect() {
    this.loadFacebookSDK();
  }

  // ETAPE 1
  loadFacebookSDK() {
    const that = this
    window.fbAsyncInit = () => {
      FB.init({
        appId      : "598892545759939", // Utilise des métadonnées ou une autre approche pour sécuriser ton App ID
        cookie     : true,
        xfbml      : true,
        version    : 'v19.0'
      });

      FB.getLoginStatus(function(response) {
        console.log(response);
        if (response.status === 'connected') {
          FB.api('/me', function(response) {
            that.buttonTarget.innerHTML = 'Vous êtes bien connecté sur le compte Facebook liée à ' + response.name + '.';
            that.buttonTarget.classList.add('disabled');
            let token = FB.getAuthResponse().accessToken;
            that.update(token)
          });
        } else {
          console.log('Vous n\'êtes pas connecté à Facebook.');
        }
      });
      FB.AppEvents.logPageView();
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

  // ETAPE 2
  facebookLogin() {
    const that = this;
    FB.login(function(response) {
      // OUVRIR LA POP UP DE CONNEXION
      if (response) {
        console.log(response);
        FB.api('/me', function(response) {
          console.log(response);
          // console.log('Vous êtes bien connecté sur le compte Facebook liée à ' + response.name + '.');
          // CHANGER LE BOUTON DE CONNEXION EN BOUTON DE DECONNEXION
          let token = FB.getAuthResponse().accessToken;
          // console.log(token);
          // ETAPE 6
          that.update(token)
          // MAINTENANT QUE JE SUIS CONNECTE? Je peux modifier les infos dans la target user
          that.buttonTarget.innerHTML = 'Vous êtes bien connecté sur le compte Facebook liée à ' + response.name + '.';
          that.buttonTarget.classList.add('disabled');
        });
      } else {
        console.log("Vous n'avez pas autorisé l\'application à se connecter à votre compte Facebook.");
      }
    },
    {
      // ETAPE 3
      // ETAPE 4 permet de déterminer les pages accessibles, si j'en sélectionne une, je peux demander les permissions pour cette page
      // Scope et autorisations
      scope: 'email,public_profile,pages_show_list,pages_read_engagement,instagram_basic,instagram_content_publish',
      return_scopes: "true",
      enable_profile_selector: "true",
      // profile_selector_ids: 'page_id'
    }
    );
  };


  // DERNIERE ETAPE AVANT DE MODIFIER LE TOKEN
  // ETAPE 7
  update(token) {
    fetch('/instagram_accounts/update', {
      method: 'PUT',
      headers: {
        'Content-Type': 'application/json',
        'X-CSRF-Token': document.querySelector("[name='csrf-token']").getAttribute('content')
      },
      body: JSON.stringify({ token: token })
    })
    .then(response => response.json())
    .then(data => {
      if(data.success) {
        console.log("Token modifié avec succès.");
      } else {
        console.error("La modification du token a échoué.");
      }
    });
  }

  // DANS LE FB API SERVICE - je vais update l'objet facebook_account de l'utilisateur
  // FB.api(/{INSTAGRAM_BUSINESS_ID}?fields=profile_picture_url,username&access_token={TOKEN}", function(response) {
    //
  //   console.log(response);
  //   POUR LA SHOW DU POST
  //   console.log(response.profile_picture_url); POUR AFFICHER LA PHOTO DE PROFIL
  //   console.log(response.username); POUR AFFICHER LE USERNAME
  // });

}




// Je peux fetch les pages de l'utilisateur connecté une fois qu'il est connecté
// Il faudrait update ses informations pour afficher le compte instagram correspondant a la page facebook à laquelle il est connecté

// Il faut récupérer le id de l'instagram_business_account pour pouvoir publier sur instagram
// FB.api('/me/accounts?fields=instagram_business_account', function(response) {
//   console.log(response);
//   console.log(response.data[0].instagram_business_account.id);
// });

// Il faut récupérer le token de la page

// Il faut récupérer la photo de profil du instagram_business_account pour l'afficher
