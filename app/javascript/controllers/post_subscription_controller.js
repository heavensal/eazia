import { Controller } from "@hotwired/stimulus"
import { createConsumer } from "@rails/actioncable"

export default class extends Controller {
  static values = { postId: Number }
  static targets = ["photos"]

  connect() {
    this.channel = createConsumer().subscriptions.create(
      { channel: "PostChannel", id: this.postIdValue },
      { received: data => {
        console.log("Received data:", data); // Ajout du log des données reçues
        this.photosTarget.insertAdjacentHTML("beforeend", data); }
      }
    )
    console.log(`Subscribed to the post with the id ${this.postIdValue}.`)
  }
}
