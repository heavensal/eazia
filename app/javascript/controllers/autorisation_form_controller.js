import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["input", "error", "checkbox", "myErrorMessage", "prompt"]

  connect() {
    // Ajout des écouteurs existants
    this.inputTargets.forEach(input => {
      input.addEventListener('blur', this.validateField.bind(this));
    });
    this.element.addEventListener('submit', this.validateForm.bind(this));
    if (this.hasCheckboxTarget) {
      this.checkboxTarget.addEventListener('change', this.validateForm.bind(this));
    }
    this.submitButton = this.element.querySelector('.btn-inscription') || this.element.querySelector('.contenu .main-bouton');

    if (this.hasPromptTarget) {
      this.promptTarget.addEventListener('input', this.validatePrompt.bind(this));
      this.promptTarget.addEventListener('focus', this.onPromptFocus.bind(this));
      this.promptTarget.addEventListener('blur', this.onPromptBlur.bind(this));
    }
  }

  validateField(event) {
    const field = event.target;
    const errorTarget = this.errorTargets.find(e => e.getAttribute("data-input-name") === field.name);

    if (!field.value) {
      field.classList.add("is-invalid");
      errorTarget.classList.remove('d-none');
    } else {
      field.classList.remove("is-invalid");
      errorTarget.classList.add('d-none');
    }
  }

  validateForm(event) {
    let isPromptValid = true; // Présumer vrai si le prompt n'existe pas
    // Vérifier et valider le prompt seulement s'il est présent
    if (this.hasPromptTarget) {
      isPromptValid = this.promptTarget.value.length >= 20;
    }

    let isCheckboxChecked = true;
       // Présumez true si pas de checkbox, pour la logique suivante.
    if (this.hasCheckboxTarget) {
      isCheckboxChecked = this.checkboxTarget.checked;
    }

    let formIsValid = isPromptValid && isCheckboxChecked;

    if (!isCheckboxChecked || !isPromptValid) {
      event.preventDefault();
      if (this.hasMyErrorMessageTarget) {
      this.myErrorMessageTarget.classList.remove('hidden');
    }
    this.submitButton.disabled = true;

    }

    if (!isPromptValid) {
      this.myErrorMessageTarget.classList.remove('d-none');
      // this.errorTarget.textContent = 'La description doit contenir au moins 20 caractères.';
    }

    else {
      if (this.hasMyErrorMessageTarget) {
      this.myErrorMessageTarget.classList.add('hidden');
      }
      this.myErrorMessageTarget.classList.add('d-none');
      this.submitButton.disabled = false;
    }

    if (formIsValid) {
    this.triggerLoaderAction(); // Déclencher le loader ici, après avoir passé la validation
  } else {
    event.preventDefault(); // Empêcher la soumission si le formulaire n'est pas valide
    // Afficher des messages d'erreur, etc.
  }

  }


  triggerLoaderAction() {
    console.log("Attempting to trigger loader action"); // Pour vérifier que cette méthode est appelée
    const loaderController = this.application.getControllerForElementAndIdentifier(
      document.querySelector("[data-controller='loader']"),
      "loader"
    );

    if (loaderController) {
      console.log("Loader controller found, triggering fire");
      loaderController.fire();
    } else {
      console.error("Loader controller not found");
    }
  }

  validatePrompt() {
    if (this.hasPromptTarget) {
      const isPromptValid = this.promptTarget.value.length >= 20;
      if (isPromptValid) {
        this.submitButton.disabled = false;
      }
    }
  }

  onPromptFocus() {
    this.submitButton.style.backgroundColor = "#FF0000";
    this.submitButton.style.color = '#fff'; // Exemple: change la couleur du texte à blanc
  }

  onPromptBlur() {
    // Réinitialisez le style du bouton principal ici après le blur
    this.submitButton.style.backgroundColor = 'linear-gradient(99deg, #233DFF 0.82%, #E17AFF 38.59%, #FD972C 95.25%);';
    this.submitButton.style.color = ''; // Réinitialise la couleur du texte
  }
}
