import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["source", "fileName", "prompt"];

  connect(){
    console.log("je suis là")
  }

  updateFileName() {

    const input = this.sourceTarget;
    const file = input.files[0];
    if (file) {
      this.fileNameTarget.textContent = file.name;
    } else {
      this.fileNameTarget.textContent = '';
    }
  }

}
