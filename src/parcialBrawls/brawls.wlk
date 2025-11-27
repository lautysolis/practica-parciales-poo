class Personaje{

    var property copasGanadas = 0

}

class Arquero inherits Personaje{

    const agilidad
    const rango

    method destreza() = agilidad * rango

    method estrategia() = rango > 100

}

class Guerrera inherits Personaje{

    const fuerza
    const estrategia 

    method destreza() = fuerza * 1.5

    method estrategia() = estrategia
}

class Ballestero inherits Arquero{

    override method destreza() = super() * 2
}

class Mision{

    var tipoPremiacion = comun

    method realizarMision(){
       self.validarCopas()
       if(self.puedeSuperar())
       self.repartirCopas()
       else
       self.quitarCopas()
    }

    method validarCopas(){
        if(!self.puedeRealizarse())
        throw new DomainException(message="Misión no puede comenzar")
    }

    method puedeSuperar() = self.tienenEstrategia() || self.tienenDestreza()

    method repartirCopas()

    method quitarCopas()

    method puedeRealizarse()

    method tienenEstrategia()

    method tienenDestreza()

    method cantidadFinalDeCopas() = tipoPremiacion.cantidadDeCopas(self)
}

class MisionIndividual inherits Mision{

    var dificultad
    var property personaje

    method copasEnJuego() = dificultad * 2

    override method tienenEstrategia() = personaje.estrategia()
    
    override method tienenDestreza() = personaje.destreza() > dificultad
    
    override method puedeRealizarse() = personaje.copas() >= 10

    override method repartirCopas() { 
        personaje.copasGanadas(personaje.copasGanadas() + self.cantidadFinalDeCopas())
    }

    override method quitarCopas(){
        personaje.copasGanadas(personaje.copasGanadas() - self.cantidadFinalDeCopas())
    }
}

class MisionDeEquipo inherits Mision{

    const property personajes = []

    method copasEnJuego() = 50 / personajes.size()

    override method puedeSuperar() = self.tienenEstrategia() || self.tienenDestreza()

    override method tienenEstrategia() = personajes.filter({personaje=> personaje.estrategia()}).size() > (personajes.size() / 2)
 
    override method tienenDestreza() = personajes.all({personaje => personaje.destreza() > 400})

    override method puedeRealizarse() = personajes.sum({personaje => personaje.copasGanadas()}) >= 60

    override method repartirCopas(){ 
        personajes.forEach({personaje => personaje.copasGanadas(personaje.copasGanadas() + self.cantidadFinalDeCopas())})
    }

    override method quitarCopas(){
        personajes.forEach({personaje => personaje.copasGanadas(personaje.copasGanadas() - self.cantidadFinalDeCopas())})
    }
}

class Boost{

var multiplicador

method cantidadDeCopas(mision) = comun.cantidadDeCopas(mision) * multiplicador

}

object bonus{

    method cantidadDeCopas(mision) = comun.cantidadDeCopas(mision) + mision.personajes().size()
}

object comun{

    method cantidadDeCopas(mision) = mision.copasEnJuego()
}