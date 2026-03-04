# 📚 BookNames - Real-Time Voting App

[![Flutter](https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white)](https://flutter.dev)
[![Socket.io](https://img.shields.io/badge/Socket.io-010101?style=for-the-badge&logo=socket.io&logoColor=white)](https://socket.io)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg?style=for-the-badge)](https://opensource.org/licenses/MIT)

Una aplicación móvil moderna construida con **Flutter** que permite gestionar una lista de libros y votar por ellos en tiempo real. Ideal para clubes de lectura, bibliotecas o simplemente para organizar tus próximas lecturas preferidas.

![BookNames Mockup](C:\Users\vlfab\.gemini\antigravity\brain\a770b6c4-c89c-47ac-9293-b32e18db3d50\booknames_app_mockup_1772588920341.png)

---

## ✨ Características Principales

-   **⚡ Tiempo Real:** Los cambios en los votos y la lista de libros se sincronizan instantáneamente en todos los dispositivos conectados gracias a WebSockets (Socket.io).
-   **📊 Gráficos Interactivos:** Visualiza la popularidad de los libros mediante un gráfico de pastel (Pie Chart) dinámico que se actualiza automáticamente al recibir nuevos votos.
-   **🧹 Swipe to Delete:** Una experiencia de usuario fluida que permite eliminar libros de la lista simplemente deslizando el elemento hacia un lado.
-   **➕ Gestión de Libros:** Añade nuevos libros fácilmente mediante un diálogo intuitivo adaptado tanto para Android como para iOS.
-   **📱 Diseño Responsivo:** Interfaz limpia y moderna utilizando Google Fonts (Poppins) y componentes Material/Cupertino para una sensación nativa.

---

## 🛠️ Tecnologías Utilizadas

-   **Frontend:** [Flutter](https://flutter.dev) (Dart)
-   **Real-time:** [Socket.io Client](https://pub.dev/packages/socket_io_client)
-   **Visualización:** [Pie Chart](https://pub.dev/packages/pie_chart)
-   **Estilos:** Google Fonts (Poppins)
-   **Backend:** Node.js con Socket.io Server

---

## 🚀 Instalación y Configuración

### 1. Clonar el repositorio
```bash
git clone https://github.com/tu-usuario/book-names.git
cd book-names
```

### 2. Obtener dependencias
Asegúrate de tener Flutter instalado y ejecuta:
```bash
flutter pub get
```

### 3. Configurar el Backend
Edita el archivo donde se configura el servidor de sockets (por ejemplo, en un `socket_service.dart` o similar) para apuntar a la IP de tu servidor:
```dart
// Ejemplo:
IO.io('http://TU_IP_AQUI:3000', ...);
```

### 4. Ejecutar la Aplicación
```bash
flutter run
```

---

## 📂 Estructura del Proyecto

```text
lib/
├── models/         # Modelos de datos (Book)
├── pages/          # Pantallas de la aplicación (Home)
├── services/       # Servicios de Sockets (Pendiente si no existe aún)
└── main.dart       # Punto de entrada
```

---

## 📸 Capturas de Pantalla

| Listado de Libros | Gráfico de Votos | Swipe para Eliminar |
| :---: | :---: | :---: |
| ![Lista](https://via.placeholder.com/200x400?text=Lista+Libros) | ![Grafico](https://via.placeholder.com/200x400?text=Pie+Chart) | ![Eliminar](https://via.placeholder.com/200x400?text=Swipe+Delete) |

---

---

## ⚡ Próximos Pasos

- [ ] Implementar autenticación de usuarios.
- [ ] Añadir persistencia en base de datos (MongoDB).
- [ ] Personalización del perfil de lector.

---

Desarrollado con ❤️ para amantes de la lectura.
