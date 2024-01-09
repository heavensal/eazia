import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["email", "password", "text"]

  connect() {
    console.log('hello')

  }

  blur() {
    if (this.emailTarget.value === "") {
      this.emailTarget.classList.add("is-invalid")
      this.textTarget.classList.remove("d-none")
    }
  else {
    this.emailTarget.classList.remove("is-invalid")
    this.textTarget.classList.add("d-none")
  }

  }

}
