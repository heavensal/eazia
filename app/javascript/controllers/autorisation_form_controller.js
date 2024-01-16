// import { Controller } from "@hotwired/stimulus"

// // Connects to data-controller="autorisation-form"
// export default class extends Controller {
//   static targets = ["email", "text"]
//   connect() {
//     console.log('hello')
//   }

//   blur() {
//     console.log("hello blur")
//     console.log(this.emailTarget)
//     console.log(this.textTarget)
//     if (this.emailTarget.value === "") {
//       this.emailTarget.classList.add("is-invalid")
//       this.textTarget.classList.remove("d-none")
//     }
//     else {
//       this.emailTarget.classList.remove("is-invalid")
//       this.textTarget.classList.add("d-none")
//     }

//     }

// }

import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["input", "error"]

  validate(event) {
    const field = event.target;
    const errorTarget = this.errorTargets.find(e => e.getAttribute("data-input-name") === field.name);

    if (field.value === "") {
      field.classList.add("is-invalid");
      errorTarget.classList.remove("d-none");
    } else {
      field.classList.remove("is-invalid");
      errorTarget.classList.add("d-none");
    }
  }
}
