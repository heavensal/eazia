import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="clic-indice"
// export default class extends Controller {
//   static values = { url: String, method: String }

//   connect() {
//     console.log("ClickableDivController connected");
//   }

//   performAction(event) {
//     event.preventDefault();
//     const { url, method } = this;

//     // Créer un élément de formulaire
//     const form = document.createElement('form');
//     form.action = url;
//     form.method = method || 'post'; // Fallback sur POST si aucune méthode n'est définie

//     // Ajouter le formulaire au corps du document et le soumettre
//     document.body.appendChild(form);
//     form.submit();
//   }
// }

export default class extends Controller {
  static targets = ["form"]

  connect(){

  }

  submitForm(event) {
    event.stopPropagation()
    this.formTarget.submit();
  }
}
