import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="flash"
export default class extends Controller {
  static targets = ["notice", "alert"]

  connect() {
    if (this.hasNoticeTarget) {
      setTimeout(() => {
        this.noticeTarget.style.display = 'none';
      }, 7000);
    }

    if (this.hasAlertTarget) {
      setTimeout(() => {
        this.alertTarget.style.display = 'none';
      }, 7000);
    }
  }

  close(event) {
    event.currentTarget.parentElement.style.display = 'none';
  }
}
