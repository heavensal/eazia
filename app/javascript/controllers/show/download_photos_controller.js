import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="show--download-photos"
export default class extends Controller {
  static targets = ["link"]

  connect() {
  }

  download(event) {
    event.preventDefault(); // Empêcher le comportement par défaut du lien

    // Récupérer l'URL à partir de l'élément cliqué
    const url = event.currentTarget.getAttribute('href');
    const filename = url.split('/').pop();

    fetch(url)
      .then(response => response.blob())
      .then(blob => {
        const downloadLink = document.createElement('a');
        downloadLink.href = URL.createObjectURL(blob);
        downloadLink.download = filename;
        document.body.appendChild(downloadLink);
        downloadLink.click();
        document.body.removeChild(downloadLink); // Nettoyer l'URL créée
      })
      .catch(error => console.error('Error downloading the image:', error));
  }
}
