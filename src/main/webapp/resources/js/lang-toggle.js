// resources/js/lang-toggle.js

function toggleLang(checkbox) {
    const form = checkbox.form;
    const hiddenLang = form.querySelector('#lang_code');
    hiddenLang.value = checkbox.checked ? 'en' : 'ko';
    form.submit();

}
