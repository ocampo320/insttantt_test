# Proyecto Flutter: Insttantt Test

Este es un proyecto de Flutter que implementa una aplicación básica con funcionalidades de autenticación, gestión de usuarios y contactos. La aplicación permite a los usuarios registrarse, iniciar sesión, y gestionar una lista de contactos.

## Versiones

- **Flutter**: 3.22.2

## Estructura del Proyecto

### Modelos

- **User**: Modelo para representar a un usuario en la aplicación. Incluye atributos como `username`, `email`, `password`, y `imagePath`.

### Repositorios

- **UserRepository**: Proporciona métodos para guardar, consultar, y eliminar usuarios en Hive. También incluye la lógica para la autenticación del usuario.

### Proveedores

- **RegisterProvider**: Maneja la lógica de registro de usuarios, incluyendo validaciones de los campos del formulario y almacenamiento de los datos en Hive.
- **AuthProvider**: Maneja el estado de autenticación del usuario, incluyendo el inicio y cierre de sesión, así como el almacenamiento de la imagen del usuario.
- **ContactsProvider**: Maneja la lista de contactos del usuario, incluyendo la adición y eliminación de contactos, y la búsqueda en la lista de contactos.

### Vistas

- **LoginScreen**: Pantalla de inicio de sesión donde los usuarios ingresan su correo electrónico y contraseña para acceder a la aplicación.
  - **Campos**: Correo electrónico y contraseña.
  - **Acciones**: Iniciar sesión, redirige al usuario a la pantalla de inicio (Home) si las credenciales son correctas. Si las credenciales son incorrectas, se muestra un mensaje de error.

- **RegisterScreen**: Pantalla de registro donde los usuarios pueden crear una cuenta nueva.
  - **Campos**: Nombre de usuario, correo electrónico, contraseña y confirmación de contraseña.
  - **Acciones**: Registrarse, que guarda la información del usuario en Hive y redirige a la pantalla de inicio (Home) si el registro es exitoso. Muestra mensajes de error si la validación de los campos falla.

- **HomeScreen**: Pantalla principal mostrada después de iniciar sesión. Muestra el nombre de usuario y la imagen del perfil.
  - **Acciones**: Permite cerrar sesión y volver a la pantalla de inicio de sesión. Incluye un botón para agregar o editar la imagen del perfil.

- **ContactsScreen**: Pantalla que muestra una lista de contactos y permite la búsqueda y adición de nuevos contactos.
  - **Campos de Búsqueda**: Permite buscar contactos por nombre o identificación.
  - **Acciones**: Agregar nuevo contacto, que abre un formulario para ingresar el nombre y la identificación del contacto.

- **AddContactScreen**: Pantalla para agregar un nuevo contacto con un formulario que incluye los campos de nombre y identificación.
  - **Campos**: Nombre del contacto (2-50 caracteres, sin números) y identificación (6-10 dígitos numéricos).
  - **Acciones**: Guardar contacto, que añade el contacto a la lista y vuelve a la pantalla de contactos actualizada.

## Configuración del Proyecto

1. **Instalación de Dependencias**

   Asegúrate de tener Flutter 3.22.2 instalado. Luego, navega a la raíz del proyecto y ejecuta:

   ```bash
   flutter pub get
   flutter run
   flutter build apk

