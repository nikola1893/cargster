self.addEventListener('beforeinstallprompt', (event) => {
  event.preventDefault();
  const a2hsButton = document.querySelector('#a2hs-button');
  a2hsButton.style.display = 'block';
  a2hsButton.addEventListener('click', () => {
    event.prompt();
    event.userChoice.then((choiceResult) => {
      if (choiceResult.outcome === 'accepted') {
        console.log('User accepted the A2HS prompt');
      } else {
        console.log('User dismissed the A2HS prompt');
      }
      a2hsButton.style.display = 'none';
    });
  });
});
