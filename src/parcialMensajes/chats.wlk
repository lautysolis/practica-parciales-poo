
class Chat{

    const property mensajes = []
    const property participantes = []


    method estaPresente(usuario) = participantes.contains(usuario)

    method tienenEspacioPara(mensaje) = participantes.all({participante => participante.puedeRecibir(mensaje)})

    method recibir(mensaje){
        self.validarRestricciones(mensaje)
        mensajes.add(mensaje)
        self.notificar()
    }

    method validarRestricciones(mensaje){
        if(not(self.puedeRecibir(mensaje)))
            throw new DomainException(message="no se puede recibir el mensaje")
    }

    method puedeRecibir(mensaje) = self.estaPresente(mensaje.emisor()) && self.tienenEspacioPara(mensaje)

    method espacioQueOcupa() = mensajes.sum({mensaje => mensaje.peso()})

    method mensajeMasPesado() = mensajes.max({mensaje => mensaje.peso()}) 

    method contiene(texto) = mensajes.any({mensaje => mensaje.contiene(texto)})

    method notificar(){
        participantes.forEach({participante => participante.recibirNoti(new Notificacion(chat=self))})
    }


}

class ChatPremium inherits Chat{

    override method puedeRecibir(mensaje) = super(mensaje) && self.puedeSerRecibido(mensaje)

    method puedeSerRecibido(mensaje) 
}

class Difusion inherits ChatPremium{

    const creador

    override method puedeSerRecibido(mensaje) = mensaje.emisor() == creador 
}

class Restringido inherits ChatPremium{

    const limite

    override method puedeSerRecibido(mensaje) = mensajes.size() <= limite
}

class Ahorro inherits ChatPremium{

    const pesoMaximo

    override method puedeSerRecibido(mensaje) = mensaje.peso() <= pesoMaximo
}


class Notificacion{

    const property chat
    var property leida = false

    method leerse(){
        leida = true
    }
}