import './bootstrap';
import AOS from 'aos';
import 'aos/dist/aos.css';

AOS.init();

console.log("AOS cargado correctamente ✅");

document.addEventListener("DOMContentLoaded", function () {
    const form = document.getElementById('newsletter-form');
    const messageBox = document.getElementById('message');

    if (form) {
        form.addEventListener('submit', async function (e) {
            e.preventDefault();

            const formData = new FormData(form);

            const response = await fetch("/subscribe", {
                method: "POST",
                headers: {
                    'X-CSRF-TOKEN': document.querySelector('input[name="_token"]').value
                },
                body: formData
            });

            const result = await response.json();

            if (result.success) {
                messageBox.classList.remove('hidden');
                messageBox.textContent = result.success;
                form.reset();
            }
        });
    }
});
