import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="random-phrases"
export default class extends Controller {
  static targets = ["phrase"];

  connect() {
    console.log("random phrase controller coucou")
    this.hideAllPhrases();
    this.showRandomPhrases();
  }

  hideAllPhrases() {
    this.phraseTargets.forEach((phrase) => {
      phrase.style.display = 'none';
    });
  }

  showRandomPhrases() {
    const sample = this.shuffleArray(this.phraseTargets).slice(0, 4);
    sample.forEach((phrase) => {
      phrase.style.display = 'block';
    });
  }

  shuffleArray(array) {
    for (let i = array.length - 1; i > 0; i--) {
      const j = Math.floor(Math.random() * (i + 1));
      [array[i], array[j]] = [array[j], array[i]];
    }
    return array;
  }
}
