import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="flash"
export default class extends Controller {
  static targets = ["notice", "alert"]

  close(event) {
    event.currentTarget.parentElement.style.display = 'none';
  }
}
