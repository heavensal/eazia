import { Controller } from "@hotwired/stimulus"

export default class extends Controller {

  submitOnFileSelect(event) {
    if (event.target.files.length > 0) {
      // Soumettre le formulaire contenant le champ de fichier
      event.target.form.submit();
    }
  }
}
