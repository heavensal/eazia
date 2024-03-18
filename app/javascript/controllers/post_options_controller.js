import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="post-options"
export default class extends Controller {
  static targets = ["menu"]

  toggle(event) {
    event.preventDefault();
    let button = event.currentTarget;
    let menu = button.nextElementSibling;


    if (menu.classList.contains('active')) {
      menu.classList.remove('active');
    } else {

      this.menuTargets.forEach((item) => {
        item.classList.remove('active');
      });
      menu.classList.add('active');
    }
  }

  delete(event) {
    event.preventDefault();

    if (confirm("Êtes-vous sûr de supprimer le brouillon ?")) {

      let draftElement = event.target.closest(".insta-show-draft");


      fetch(event.target.href, {
        method: 'DELETE',
        headers: {
          'X-CSRF-Token': document.querySelector("[name='csrf-token']").content,
          'Accept': 'text/vnd.turbo-stream.html, text/html, application/xhtml+xml'
        },
        credentials: 'same-origin'
      }).then(response => {
        if (response.ok) {
          draftElement.remove();
        } else {
          alert("Une erreur s'est produite lors de la suppression du brouillon.");
        }
      }).catch(error => console.error('Erreur de suppression:', error));
    }
  }
}
