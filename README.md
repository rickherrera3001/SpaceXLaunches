# 🚀 SpaceX Launches App

Una aplicación iOS construida en SwiftUI que consume la API pública de SpaceX para mostrar los lanzamientos pasados. Implementa autenticación con Firebase, almacenamiento local con SwiftData y un flujo robusto en arquitectura MVVM + Coordinator.

---

## 🌐 API

Se consume la API oficial de SpaceX:

```
https://api.spacexdata.com/v3/launches/past
```

---

## 🧱 Arquitectura

- **MVVM** para separación de lógica de presentación y datos.
- **Coordinator Pattern** para manejar navegación de manera escalable.
- **SwiftData** para almacenamiento local de lanzamientos.
- **Alamofire** para networking (peticiones HTTP y carga de imágenes).
- **YouTubePlayerKit** para visualizar los videos de cada lanzamiento.

---

## 🧠 Lógica de sincronización

- Al iniciar la app, se verifica si la información de lanzamientos ya fue descargada hoy.
- Si es así, se usa la data persistida en SwiftData.
- Si no, se hace un nuevo `fetch` desde la API, se guarda localmente y se actualiza la fecha del último fetch.
- Esta lógica está encapsulada en un `LaunchDataManager`.

---

## 🔐 Autenticación

- Implementada con **Firebase Auth**.
- Flujo completo: **Login**, **Registro**, y **Recuperación de contraseña**.
- Solo usuarios autenticados pueden acceder a la vista principal de lanzamientos.

---

## 🖼 Funcionalidad de Launches

- Lista de lanzamientos pasados con:
  - Nombre de la misión
  - Lugar de lanzamiento
  - Fecha del lanzamiento (formateada al estilo español)
  - Imagen del parche de la misión
- Cada celda lleva a una vista de detalle con más información.
- Si el lanzamiento incluye video, se muestra incrustado con `YouTubePlayer`.

---

## 🧪 Requisitos

- Xcode 15+
- iOS 17+
- Swift 5.9+

---

## 📦 Dependencias

- [Alamofire](https://github.com/Alamofire/Alamofire)
- [FirebaseAuth](https://firebase.google.com/docs/auth/ios/start)
- [YouTubePlayerKit](https://github.com/SvenTiigi/YouTubePlayerKit)

---

## ✍️ Autor

Desarrollado por **Ricardo Herrera** — iOS dev.

---



## ✅ Próximas mejoras (opcional)

- Modo offline completo
- Buscador por nombre de misión
- Favoritos sincronizados con Firebase
- Dark mode
