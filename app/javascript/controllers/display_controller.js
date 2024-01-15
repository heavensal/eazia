import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="display"
export default class extends Controller {
  connect() {
    console.log("STIMULUS FONCTIONNE");
  }
}
