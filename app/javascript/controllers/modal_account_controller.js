import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="modal-account"
export default class extends Controller {
  static targets = ["modal", "overlay", "info", "photo", "ia"];

  connect(){
    console.log("Modal account controller connected");
  }

  open(event) {
    event.preventDefault();
    event.stopPropagation();

    const modalName = event.currentTarget.dataset.modalName;

    this.infoTargets.forEach((info) => {
      if (info.dataset.modalName === modalName) {
        info.classList.add("show");
        info.style.display = "block";
      } else {
        info.classList.remove("show");
        info.style.display = "none";
      }
    });

    this.photoTargets.forEach((photo) => {
      if (photo.dataset.modalName === modalName) {
        photo.classList.add("show");
        photo.style.display = "block";
      } else {
        photo.classList.remove("show");
        photo.style.display = "none";
      }
    });

    this.iaTargets.forEach((ia) => {
      if (ia.dataset.modalName === modalName) {
        ia.classList.add("show");
        ia.style.display = "block";
      } else {
        ia.classList.remove("show");
        ia.style.display = "none";
      }
    });

    if (this.hasModalTarget) {
    this.modalTarget.classList.add("show");
    this.modalTarget.style.display = "block";
    this.modalTarget.removeAttribute("aria-hidden");
    this.modalTarget.setAttribute("aria-modal", "true");
    this.modalTarget.setAttribute("role", "dialog");
    }
    if (this.hasOverlayTarget) {
    this.overlayTarget.style.display = "block"; // Afficher l'overlay
    }

    if (this.hasModalTarget || this.hasOverlayTarget || this.infoTarget || this.photoTarget || this.iaTarget) {
      document.body.classList.add("modal-open");
    }


    // if (this.hasInfoTarget) {
    //   console.log(this.infoTarget);
    // this.infoTarget.classList.add("show");
    // this.infoTarget.style.display = "block";
    // this.infoTarget.removeAttribute("aria-hidden");
    // this.infoTarget.setAttribute("aria-modal", "true");
    // this.infoTarget.setAttribute("role", "dialog");
    // }

    // if (this.hasPhotoTarget) {
    //   this.photoTarget.classList.add("show");
    //   this.photoTarget.style.display = "block";
    //   this.photoTarget.removeAttribute("aria-hidden");
    //   this.photoTarget.setAttribute("aria-modal", "true");
    //   this.photoTarget.setAttribute("role", "dialog");
    //   }


    // if (this.hasIaTarget) {
    //   this.iaTarget.classList.add("show");
    //   this.iaTargetTarget.style.display = "block";
    //   this.iaTarget.removeAttribute("aria-hidden");
    //   this.iaTarget.setAttribute("aria-modal", "true");
    //   this.iaTarget.setAttribute("role", "dialog");
    //   }



  }

  close() {
    if (this.hasModalTarget) {
    this.modalTarget.classList.remove("show");
    this.modalTarget.style.display = "none";
    this.modalTarget.setAttribute("aria-hidden", "true");
    this.modalTarget.removeAttribute("aria-modal");
    this.modalTarget.removeAttribute("role");
    }

    if (this.hasOverlayTarget) {
    this.overlayTarget.style.display = "none"; // Cacher l'overlay
    }

    if (this.hasModalTarget || this.hasOverlayTarget || this.infoTarget || this.photoTarget || this.iaTarget) {
      document.body.classList.remove("modal-open");
    }

    if (this.hasInfoTarget) {
      this.infoTarget.classList.remove("show");
      this.infoTarget.style.display = "none";
      this.infoTarget.setAttribute("aria-hidden", "true");
      this.infoTarget.removeAttribute("aria-modal");
      this.infoTarget.removeAttribute("role");
    }

    if (this.hasPhotoTarget) {
      this.photoTarget.classList.remove("show");
      this.photoTarget.style.display = "none";
      this.photoTarget.setAttribute("aria-hidden", "true");
      this.photoTarget.removeAttribute("aria-modal");
      this.photoTarget.removeAttribute("role");
    }
    if (this.hasIaTarget) {
      this.iaTarget.classList.remove("show");
      this.iaTarget.style.display = "none";
      this.iaTarget.setAttribute("aria-hidden", "true");
      this.iaTarget.removeAttribute("aria-modal");
      this.iaTarget.removeAttribute("role");
    }
  }
}
