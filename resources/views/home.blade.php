<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Danza Moderna</title>
    @vite('resources/css/app.css')
    @vite('resources/js/app.js')
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
</head>


<body class="bg-gray-100 font-sans text-gray-800">

    <div class="min-h-screen flex flex-col items-center justify-center p-6">
        <div class="bg-white shadow-2xl rounded-2xl p-10 max-w-5xl mx-auto w-full text-center">
            <img src="{{ asset('images/ilustraciondanza.JPG') }}" alt="Imagen de Danza"
     class="w-full h-64 object-cover rounded-xl mb-6 shadow-md">

            <h1 class="text-4xl font-bold text-blue-400 mb-4" 
            data-aos="fade-up"
            data-aos-once="false"
             >Bienvenido a mi pagina
            </h1>
            <p class="mb-6 text-gray-600 mb-6"data-aos="fade-up" data-aos-delay="100">
              Únete a nuestro grupo exclusivo y accede a contenido especial sobre la danza.
            </p>

      <!-- Botón de WhatsApp -->
<a href="https://chat.whatsapp.com/tu-enlace" target="_blank" class="bg-green-500 hover:bg-green-600 text-white font-bold py-2 px-4 rounded flex items-center justify-center gap-2 mb-3" 
 data-aos="zoom-in"
   data-aos-delay="200"
   data-aos-once="false">
    
  <svg xmlns="http://www.w3.org/2000/svg" class="w-5 h-5 fill-white" viewBox="0 0 448 512">
    <path d="M380.9 97.1C339 55.1 283.2 32 223.9 32c-122.4 0-222 99.6-222 222 0 39.1 10.2 77.3 29.6 111L0 480l117.7-30.9c32.4 17.7 68.9 27 106.1 27h.1c122.3 0 224.1-99.6 224.1-222 0-59.3-25.2-115-67.1-157zm-157 341.6c-33.2 0-65.7-8.9-94-25.7l-6.7-4-69.8 18.3L72 359.2l-4.4-7c-18.5-29.4-28.2-63.3-28.2-98.2 0-101.7 82.8-184.5 184.6-184.5 49.3 0 95.6 19.2 130.4 54.1 34.8 34.9 56.2 81.2 56.1 130.5 0 101.8-84.9 184.6-186.6 184.6zm101.2-138.2c-5.5-2.8-32.8-16.2-37.9-18-5.1-1.9-8.8-2.8-12.5 2.8-3.7 5.6-14.3 18-17.6 21.8-3.2 3.7-6.5 4.2-12 1.4-32.6-16.3-54-29.1-75.5-66-5.7-9.8 5.7-9.1 16.3-30.3 1.8-3.7 .9-6.9-.5-9.7-1.4-2.8-12.5-30.1-17.1-41.2-4.5-10.8-9.1-9.3-12.5-9.5-3.2-.2-6.9-.2-10.6-.2-3.7 0-9.7 1.4-14.8 6.9-5.1 5.6-19.4 19-19.4 46.3 0 27.3 19.9 53.7 22.6 57.4 2.8 3.7 39.1 59.7 94.8 83.8 35.2 15.2 49 16.5 66.6 13.9 10.7-1.6 32.8-13.4 37.4-26.4 4.6-13 4.6-24.1 3.2-26.4-1.3-2.5-5-3.9-10.5-6.6z"/>
  </svg>
  Unirme al Grupo de WhatsApp
</a>


         <!-- Botón de Compra -->
<a href="https://link-de-tu-libro.com" target="_blank"
   class="bg-indigo-600 hover:bg-indigo-700 text-white font-bold py-2 px-4 rounded flex items-center justify-center gap-2"  data-aos="zoom-in" data-aos-delay="200">
  <svg xmlns="http://www.w3.org/2000/svg" class="w-5 h-5 fill-white" viewBox="0 0 576 512">
    <path d="M528.1 301.3l47.3-208c1.3-5.5 .2-11.3-3.1-15.8s-8.5-7.1-13.9-7.1H128l-12.6-50.3C113.6 7 104.3 0 93.9 0H24C10.7 0 0 10.7 0 24s10.7 24 24 24h51.8l70.2 279.5c-21.1 8.7-36 29.4-36 53.5 0 31.8 25.8 57.5 57.5 57.5h288c13.2 0 24-10.7 24-24s-10.8-24-24-24H167.5c-5.5 0-9.5-4-9.5-9.5s4-9.5 9.5-9.5H440c25.3 0 46.6-17.4 52.1-41.3z"/>
  </svg>
  Comprar el Libro de Danza
</a>
            <div class="mt-10 text-left">
    <h2 class="text-2xl font-bold text-gray-800 mb-4" •	data-aos="zoom-out-down">¿Quiénes somos?</h2>
    <p class="text-gray-600 leading-relaxed" •	data-aos="zoom-out-down">
       Lorem ipsum dolor sit amet. Et tempore enim sit pariatur porro qui iusto laudantium aut aliquid autem. Ex ratione officia in modi reprehenderit cum doloremque ipsa eum repellat tenetur qui suscipit vitae qui magnam deserunt non perferendis architecto.
    </p>
</div>
<section class="py-12 bg-white" id="galeria">
  <div class="max-w-6xl mx-auto px-4 text-center">
    <h2 class="text-3xl font-bold text-gray-800 mb-8" data-aos="fade-up">Galería de Danza</h2>
    <div class="grid grid-cols-1 sm:grid-cols-2 md:grid-cols-3 gap-6">
      <img src="{{ asset('images/G1.jpg') }}" alt="Galería 1"
           class="rounded-xl shadow-lg object-cover w-full h-60"
           data-aos="zoom-in" data-aos-delay="100" data-aos-once="false">

      <img src="{{ asset('images/G2.jpg') }}" alt="Galería 2"
           class="rounded-xl shadow-lg object-cover w-full h-60"
           data-aos="zoom-in" data-aos-delay="200" data-aos-once="false">

      <img src="{{ asset('images/G3.jpg') }}" alt="Galería 3"
           class="rounded-xl shadow-lg object-cover w-full h-60"
           data-aos="zoom-in" data-aos-delay="300" data-aos-once="false">
    </div>
  </div>

<footer class="bg-gray-800 text-white py-8 mt-10">
  <div class="max-w-6xl mx-auto px-4 text-center">
    <h3 class="text-xl font-semibold mb-4" data-aos="fade-up">Síguenos en redes sociales</h3>
    
    <div class="flex justify-center space-x-6" data-aos="fade-up" data-aos-delay="200">
      <!-- Instagram -->
     
        <a href="https://instagram.com/tu_cuenta" target="_blank"
   class="hover:text-pink-500 transition duration-300 ease-in-out inline-flex items-center justify-center w-10 h-10 rounded-full border border-gray-300 hover:bg-pink-100">
  <svg xmlns="http://www.w3.org/2000/svg" class="w-6 h-6 fill-current" viewBox="0 0 50 50">
    <path d="M 16 3 C 8.8324839 3 3 8.8324839 3 16 L 3 34 C 3 41.167516 8.8324839 47 16 47 L 34 47 C 41.167516 47 47 41.167516 47 34 L 47 16 C 47 8.8324839 41.167516 3 34 3 L 16 3 z M 16 5 L 34 5 C 40.086484 5 45 9.9135161 45 16 L 45 34 C 45 40.086484 40.086484 45 34 45 L 16 45 C 9.9135161 45 5 40.086484 5 34 L 5 16 C 5 9.9135161 9.9135161 5 16 5 z M 37 11 A 2 2 0 0 0 35 13 A 2 2 0 0 0 37 15 A 2 2 0 0 0 39 13 A 2 2 0 0 0 37 11 z M 25 14 C 18.936712 14 14 18.936712 14 25 C 14 31.063288 18.936712 36 25 36 C 31.063288 36 36 31.063288 36 25 C 36 18.936712 31.063288 14 25 14 z M 25 16 C 29.982407 16 34 20.017593 34 25 C 34 29.982407 29.982407 34 25 34 C 20.017593 34 16 29.982407 16 25 C 16 20.017593 20.017593 16 25 16 z"/>
  </svg>
</a>

      </a>

      <!-- TikTok -->
  <a href="https://www.tiktok.com/@tu_usuario" target="_blank"
  class="hover:text-red-400 transition duration-300 ease-in-out inline-flex items-center justify-center w-10 h-10 rounded-full border border-gray-300 hover:bg-red-50">
  <svg xmlns="http://www.w3.org/2000/svg" class="w-6 h-6 fill-current" viewBox="0 0 50 50">
    <path d="M 9 4 C 6.2495759 4 4 6.2495759 4 9 L 4 41 C 4 43.750424 6.2495759 46 9 46 L 41 46 C 43.750424 46 46 43.750424 46 41 L 46 9 C 46 6.2495759 43.750424 4 41 4 L 9 4 z M 9 6 L 41 6 C 42.671576 6 44 7.3284241 44 9 L 44 41 C 44 42.671576 42.671576 44 41 44 L 9 44 C 7.3284241 44 6 42.671576 6 41 L 6 9 C 6 7.3284241 7.3284241 6 9 6 z M 26.042969 10 A 1.0001 1.0001 0 0 0 25.042969 10.998047 C 25.042969 10.998047 25.031984 15.873262 25.021484 20.759766 C 25.016184 23.203017 25.009799 25.64879 25.005859 27.490234 C 25.001922 29.331679 25 30.496833 25 30.59375 C 25 32.409009 23.351421 33.892578 21.472656 33.892578 C 19.608867 33.892578 18.121094 32.402853 18.121094 30.539062 C 18.121094 28.675273 19.608867 27.1875 21.472656 27.1875 C 21.535796 27.1875 21.663054 27.208245 21.880859 27.234375 A 1.0001 1.0001 0 0 0 23 26.240234 L 23 22.039062 A 1.0001 1.0001 0 0 0 22.0625 21.041016 C 21.906673 21.031216 21.710581 21.011719 21.472656 21.011719 C 16.223131 21.011719 11.945313 25.289537 11.945312 30.539062 C 11.945312 35.788589 16.223131 40.066406 21.472656 40.066406 C 26.72204 40.066409 31 35.788588 31 30.539062 L 31 21.490234 C 32.454611 22.653646 34.267517 23.390625 36.269531 23.390625 C 36.542588 23.390625 36.802305 23.374442 37.050781 23.351562 A 1.0001 1.0001 0 0 0 37.958984 22.355469 L 37.958984 17.685547 A 1.0001 1.0001 0 0 0 37.03125 16.6875 C 33.886609 16.461891 31.379838 14.012216 31.052734 10.896484 A 1.0001 1.0001 0 0 0 30.058594 10 L 26.042969 10 z M 27.041016 12 L 29.322266 12 C 30.049047 15.2987 32.626734 17.814404 35.958984 18.445312 L 35.958984 21.310547 C 33.820114 21.201935 31.941489 20.134948 30.835938 18.453125 A 1.0001 1.0001 0 0 0 29 19.003906 L 29 30.539062 C 29 34.707538 25.641273 38.066406 21.472656 38.066406 C 17.304181 38.066406 13.945312 34.707538 13.945312 30.539062 C 13.945312 26.538539 17.066083 23.363182 21 23.107422 L 21 25.283203 C 18.286416 25.535721 16.121094 27.762246 16.121094 30.539062 C 16.121094 33.483274 18.528445 35.892578 21.472656 35.892578 C 24.401892 35.892578 27 33.586491 27 30.59375 C 27 30.64267 27.001859 29.335571 27.005859 27.494141 C 27.009759 25.65271 27.016224 23.20692 27.021484 20.763672 C 27.030884 16.376775 27.039186 12.849206 27.041016 12 z"/>
  </svg>
</a>



      <!-- Facebook -->
  <a href="https://www.facebook.com/tu_pagina" target="_blank"
   class="hover:text-blue-600 transition duration-300 ease-in-out inline-flex items-center justify-center w-10 h-10 rounded-full border border-gray-300 hover:bg-blue-200">

  <svg xmlns="http://www.w3.org/2000/svg" class="w-5 h-5 fill-current" viewBox="0 0 50 50">
    <path d="M 25 3 C 12.861562 3 3 12.861562 3 25 C 3 36.019135 11.127533 45.138355 21.712891 46.728516 L 22.861328 46.902344 L 22.861328 29.566406 L 17.664062 29.566406 L 17.664062 26.046875 L 22.861328 26.046875 L 22.861328 21.373047 C 22.861328 18.494965 23.551973 16.599417 24.695312 15.410156 C 25.838652 14.220896 27.528004 13.621094 29.878906 13.621094 C 31.758714 13.621094 32.490022 13.734993 33.185547 13.820312 L 33.185547 16.701172 L 30.738281 16.701172 C 29.349697 16.701172 28.210449 17.475903 27.619141 18.507812 C 27.027832 19.539724 26.84375 20.771816 26.84375 22.027344 L 26.84375 26.044922 L 32.966797 26.044922 L 32.421875 29.564453 L 26.84375 29.564453 L 26.84375 46.929688 L 27.978516 46.775391 C 38.71434 45.319366 47 36.126845 47 25 C 47 12.861562 37.138438 3 25 3 z"/>
  </svg>
</a>

    </div>
    
    <p class="mt-6 text-sm text-gray-400">&copy; 2025 Danza Moderna. Todos los derechos reservados.</p>
  </div>
</footer>

</body>
</html>
