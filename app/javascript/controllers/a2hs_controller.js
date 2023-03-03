export default class extends Stimulus.Controller {
  static values = {
    modalTarget: String,
    modalContentTarget: String,
  }

  initialize() {
    window.addEventListener('beforeinstallprompt', (event) => {
      // Prevent Chrome 67 and earlier from automatically showing the prompt
      event.preventDefault();

      // Show the modal
      this.showModal();

      // Store the event for later use
      this.promptEvent = event;
    });

    // Check if the app is already installed
    window.addEventListener('appinstalled', () => {
      // Hide the modal
      this.hideModal();
    });
  }

  showModal() {
    this.modalTarget.classList.add('is-active');
    this.modalContentTarget.innerHTML = "Add to home screen?";
  }

  hideModal() {
    this.modalTarget.classList.remove('is-active');
  }

  addToHomeScreen() {
    // Show the install prompt
    this.promptEvent.prompt();

    // Wait for the user to respond to the prompt
    this.promptEvent.userChoice.then((choiceResult) => {
      if (choiceResult.outcome === 'accepted') {
        // User accepted the prompt
        console.log('User accepted the A2HS prompt');
      } else {
        // User dismissed the prompt
        console.log('User dismissed the A2HS prompt');
      }

      // Hide the modal
      this.hideModal();

      // Clear the promptEvent variable
      this.promptEvent = null;
    });
  }
}
