class Mensaje{

    const contenido
    var property emisor

    method peso() = 5 + contenido.peso() * 1.3  

    method contiene(texto) = emisor.nombre().contains(texto) || contenido.contiene(texto)

}

class Texto{

    const texto

    method peso() = texto.size() 

    method contiene(textox) = texto.contains(textox) 

}

class Audio{

    const duracion

    method peso() =  duracion * 1.2

    method contiene(texto) = false 

}

class Contacto{

    var usuarioAenviar

    method peso() = 3

    method contiene(texto) = usuarioAenviar.contains(texto)
}

class Imagen{

    const alto
    const ancho
    var modoCompresion

    method pixeles() = alto * ancho

    method peso() = modoCompresion.peso(self) * self.pesoXpixel()

    method pesoXpixel() = 2

    method contiene(texto) = false 
}


object compresionOriginal {
  
  method peso(imagen) = imagen.pixeles()
}

class CompresionVariable{

    var porcentajeCompresion

    method peso(imagen) = imagen.pixeles() * porcentajeCompresion 
}

class CompresionMaxima {

    const cantidadMax = 10000
  
    method peso(imagen) = imagen.pixeles().min(cantidadMax)

}

class Gift inherits Imagen{

    const cantidadCuadros

    override method peso() = super() * cantidadCuadros
}