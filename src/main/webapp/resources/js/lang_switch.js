const langSwitch = document.getElementById('langSwitch');
 const langLabel = document.getElementById('langLabel');

 langSwitch.addEventListener('change', function() {
   if (langSwitch.checked) {
     langLabel.textContent = 'English';
   } else {
     langLabel.textContent = 'Korean';
   }
 });