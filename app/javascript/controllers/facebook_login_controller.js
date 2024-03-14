import { Controller } from "@hotwired/stimulus"
import * as bootstrap from "bootstrap";

// Connects to data-controller="facebook-login"
export default class extends Controller {
  connect() {
    new bootstrap.Modal(document.getElementById('facebookLoginModal')).show();
  }
}
