
class Noticia{

    const property fechaPublicacion
    const publicante
    const importancia
    const property titulo
    const property desarrollo
 
   
    method esReciente(){
        var fechaActual = new Date()
        return fechaActual - fechaPublicacion < 3   
    } 

    method esImportante() = importancia >= 8

    method esCopada() = self.esImportante() && self.esReciente() 

    method publicarse() = publicante.publicar(self)

    method esSensacionalista() = self.contienePalabraSensacional() 

    method contienePalabraSensacional() = titulo.contains("espectacular") || titulo.contains("increible") || titulo.contains("grandioso")

    method escrituraValida() = self.tieneTituloValido() && self.tieneDesarrollo()

    method tieneTituloValido() = titulo.split(" ").size() >= 2

    method tieneDesarrollo() = desarrollo.size() > 0

    method tieneMenosDeUnaSemana(){
        var fechaActual = new Date()
        return fechaActual - fechaPublicacion < 7
    }

}

class ArticuloComun inherits Noticia{

    const noticias

    override method esCopada() =  super() && self.cantidadDeLinks() >= 2

    method cantidadDeLinks() = noticias.size()

}

class Chivo inherits Noticia{
    
    var dineroRecibido

    override method esCopada() = super() && dineroRecibido > 2000000

}

class Reportaje inherits Noticia{

    var reportado

    override method esCopada() = super() && self.esImpar(reportado)

    method esImpar(texto) = texto.length() % 2 != 0

    override method esSensacionalista() = super() && reportado == "Dibu Martínez"
}

class Cobertura inherits Noticia{

    const noticias

    override method esCopada() = super() && noticias.all({noticia => noticia.esCopada()}) 

}


class Periodista{

    const fechaIngreso
    var preferencias
    const noticiasPublicadas = []

    method prefierePublicar(noticia) = preferencias.prefierePublicar(noticia)

    method publicar(noticia){
        if(!noticia.escrituraValida())
            throw new DomainException(message="no se puede publicar")
        else if(!self.validarPreferencias(noticia))
            throw new DomainException(message="no se puede publicar")
        
        self.agregarPublicacion(noticia)
    }
    
    method noticiasNoPreferidasEn(fecha) =
        noticiasPublicadas.filter({n => !self.prefierePublicar(n) && n.fechaPublicacion() == fecha})

    method validarPreferencias(noticia) = self.prefierePublicar(noticia) || self.noticiasNoPreferidasEn(noticia.fechaPublicacion()).size() <= 2

    method agregarPublicacion(noticia){
        noticiasPublicadas.add(noticia)
    }

    method esReciente(){
        const anioActual = new Date().year()
        return anioActual - fechaIngreso <= 1
    }

    method publicoEnUltimaSemana() = noticiasPublicadas.any({n => n.tieneMenosDeUnaSemana()})

    method esNuevoyPublicoEnUltimaSemana() = self.esReciente() && self.publicoEnUltimaSemana()
}


class PreferenciasCopadas{

    method prefierePublicar(noticia) = noticia.esCopada()
}

class PreferenciasSensacionalistas{

    method prefierePublicar(noticia) = noticia.esSensacionalista() 
}

class PreferenciasVagas{

    method prefierePublicar(noticia) = noticia.isKindOf(Chivo)  || (noticia.desarrollo().split(" ").size() < 100
)
}

object joseDeZer{
  
    method prefierePublicar(noticia) = noticia.titulo().first() == 'T'
}