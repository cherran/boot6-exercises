//: [Previous](@previous)  - [Next](@next)

import UIKit


//: # Grand Central Dispatch

#imageLiteral(resourceName: "19228-2.png")
//: GCD es una librería de alto nivel que permite manejar la concurrencia y paralelismo sin
//: "ensuciarse" las manos con cuestiones de bajo nivel. Con GCD podemos llevar a cabo varias tareas
//: preservando el orden entre las mismas, cuando sea necesario.

//: ## El problema del no-determinismo
//: Vámonos un segundo a un programita en `Go` que muestra de forma muy sencilla uno de los principales
//: desafíos a los que nos enfrentamos al escribir código concurrente.

//: ### Paralelismo vs Concurrencia
//: El `paralelismo` es un aspecto del hardware: distribuir varias tareas entre distintos cores. De esta forma`,
//: realmente se están haciendo varias cosas a la vez.
//: Las CPUs de Apple tienen en su mayoría varios nucleos, con la excepción del Watch que es mono-nucleo.
//: El chip A11 de Apple (usado en el iPhone X & 8) tiene 6 nucleos:
//: * 2 optimizados para el rendimiento
//: * 4 optimizados para la eficiencia energética

//: `GCD` se encarga de encender y apagar esos nucleos asi como distribuir nuestro código por ellos para que el rendimiento
//: y la eficiencia sean óptimas, *sin que nosotros nos tengamos que preocupar por ello*.

#imageLiteral(resourceName: "chuck-norris-ok.jpg")
//: Gracias, GCD!


//: ## APIs para manejar GCD

//: Existen dos, que hacen exactamente lo mismo, pero de manera levemente diferente.

//: API basada en colas y clausuras. Es la más *funcional* y tal vez más *swiftera*. Es mi favorita y suele
//: ser usada por
#imageLiteral(resourceName: "c31efae83bdc081e1cf627c6476a0d3b--danny-trejo-danny-odonoghue.jpg")
//: Dicen las malas lenguas que en cierto curso online, *alguien* afirma que los *hombres con percebes en elos huevos* usan esta API.
#imageLiteral(resourceName: "se-100.jpeg")
//: Luego está la que utiliza clases para representar las colas `NSOperationQueue` y y las clausuras `NSOperation`.
//: Recuerda un poco a Java (¡puaj!) y suele ser usada por
#imageLiteral(resourceName: "2e30f0c50e22d19d5d8dcd2a0ba48547.jpg")

//: Nos centraremos en la primera, aunque es totalmente cuestión de gustos (básicamente, el mío y el malo 🤓)

//: ## Colas

//: La principal herramienta que tiene GCD son las colas. Son la forma de llevar a cabo tareas en hebras distintas, sin tener que manejar hebras directamente (es peligroso y proclive a errores) y preservando, *cuando hace falta* el orden y la causalidad.
//: Hay dos tipos de colas.
//: #### Colas síncronas
//: Son las que más vamos a usar y son *colas de verdad*: en el sentido de que son estrcuturas de datos FIFO. ¿Qué cosas se meten dentro de dichas colas? *Clausuras*. Las clausuras (bloques en Objective C) *empaquetan* aquel código que queremos que se ejecute en otra hebra o en segundo plano.  La cola tiene una hebra y va sacando las clausuras una por una y las ejecuta en dicha hebra.

//: Dicho esto, los más espabilaos se estarán preguntado, si se ejecutan las clausuras una detrás de la otra, *¿donde carallo está la concurrencia?* -> 
#imageLiteral(resourceName: "explain-this-shit.jpg")

//: > Islas de causalidad en un mar de indeterminismo.

//: *Un friki poeta de Apple en un WWDC sobre Grand Central Dispatch (con dos cojones).*

//: ### Colas Asíncronas
//: No son colas en el sentido estricto de la palabra, ya que tienen varias hebras y van atendidendo a las clausuras según le apetece en la hebra que le apetece. Permiten ejecutar varias tareas a la vez en una misma *cola*, pero no son *islas de causalidad*.
//: Vamos a usar ambas, pero empezando por las síncronas que son más sencillas de entender.

//: ## las colas tienen prioridades

//: Aunque todas las clausuras dentro de una cola son tratadas de igual forma (todas tienen la misma prioridad), las colas en sí son tratadas de distinta forma por el sistema operativo. Hay 5 niveles de prioridad, o *clases de calidad del servicio*:

public enum QoSClass {
    
    case background     // Ni caso
    
    case utility
    
    case `default`
    
    case userInitiated
    
    case userInteractive // Máxima atención
    
    case unspecified
    
}


//: ## La Madre de todas las colas: la principal

//: Hay una cola que es más especial que ninguna otra: la que atiende a la interfaz de usuario. Se le llama cola principal y es aquella que ejecuta el código de nuestra aplicación si no decimos lo contrario. Hasta hoy, todo tu código se ha ejecutado en dicha cola. A partir de ahora tendremos opciones.

//: Es vital _nunca_ bloquear la cola principal. Si lo haces, además de dar un pésimo servicio al usurio, tu App puede ser rechazada en la App Store o cerrada por el sistema operativo.  Por lo tanto,
//: > Toda tarea larga debe de ser ejecutada en una cola que no sea la principal.

/*: ### Ciertas cosas sólo se pueden ejecutar en la cola principal
Algunas frameworks no están preparadas para que su código se ejecute en otro sitio que no sea la cola principal. Dos buenos ejemplos son UIKit y CoreData.

 
*/



//: [Next](@next)
