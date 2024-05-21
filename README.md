# ConexNews

Mobile Challenge:
Crear una aplicación de lectura de noticias.

https://conexatech.notion.site/Mobile-Challenge-d1cd3b19418d45fd92780cc228c1ac86

## **Introducción:**

La aplicación debe constar de 4 pantallas:

- Lista y buscador de noticias por título o contenido (Pantalla de Inicio)
- Detalles de la noticia seleccionada (Pantalla de Detalle)
- Lista de usuarios (Pantalla de Usuarios)
- Ubicación en el mapa del usuario (Pantalla de Mapa)

La app deberá ser una lista de noticias y una lista de usuarios. En la lista de usuarios debe mostrarse un botón que abra la pantalla de mapa, en donde con Google Maps debe mostrar la ubicación del usuario seleccionado. No hay restricciones en cuanto a los datos que se muestran tanto de las noticias como de los usuarios.

## **Documentación:**

**Control de versionado**

El primer paso fue clonar el repositorio vacío y crear el proyecto en Xcode.
Una vez hecho esto, cree una rama nueva llamada develop, en la que hice algunas configuraciones básicas para la app.

De la rama mencionada, saqué dos feature branchs, llamadas feature/news y feature/users, en las que trabajé cada sección por separado hasta estar terminadas.
Cuando consideré que el desarrollo de cada feature estaba terminado, hice un PR hacia develop.

Terminadas ambas features, me puse a trabajar en los unit tests, de los cuales pude realizar solo los más básicos por cuestiones de tiempo.
Ya pasados los tests con éxito y viendo que la aplicación estaba completa, hice el último PR de develop a main, dando por terminado el desarrollo.


**Arquitectura**

Utilicé la arquitectura MVVM, sumando repositorios para cada modelo de dato, pudiendo así utilizar URLSession con JSONPlaceholder para cuando la app corría y unos modelos Mock para los Tests.
Intenté mantener un código limpio y ordenado, queriendo mantener un enfoque en Clean Architecture.
Para la creación de los modelos de datos me ayudé de una web que facilita el mapeo de modelos Json que utilizo frecuentemente, dado que facilita esta tarea enormemente. (https://app.quicktype.io/)

**XCode y Swift**

Decidí utilizar UIKit con XIBs para la interfaz, ya que no era requerida una UI muy elaborada, por lo que con pocos elementos se me hace cómodo trabajar de esta manera.

Para ambas listas (noticias y usuarios) utilicé UITableView y UITableViewCell, contenidas en un UIViewController para cada sección, un UITabBarController que maneja toda la navegación de la app siendo este mismo instanciado en el SceneDelegate una vez que la aplicación es iniciada.

El buscador de noticias lo realicé con un UISearchBar en el View Controller correspondiente, implementando su delegate para poder manejar la búsqueda.

Cree un ViewController para poder ver el detalle de cada noticia, mostrando los datos que consideré más importantes a mostrar en dicha pantalla.

Volviendo a la sección de Usuarios, se abre el navegador del dispositivo con la web de Google Maps, con las coordenadas del usuario que se seleccionó al tocar su celda. Me hubiera gustado implementar el SDK de Google Maps para tener una pantalla dedicada y tener un resultado mas profesional, pero por cuestiones de tiempo y dificultad para obtener todo lo necesario para que funcione, tuve que descartar la idea.

Por último, cree un proyecto de Pods, para el que utilice Toast-Swfit, una librería que permite mostrar un mensaje en pantalla por unos segundos de manera sencilla.
Decidí utilizarlo para informar cuando había un error de conexión o algo similar.
https://cocoapods.org/pods/Toast-Swift
