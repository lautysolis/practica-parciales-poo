class Usuario{

    var espacioMemoria
    const chats = []
    const notis = []
    const property nombre

    method mensajesMasPesados() = chats.map({chat => chat.mensajeMasPesado()})
    
    method puedeRecibir(mensaje) = espacioMemoria >=  mensaje.peso() + self.espacioOcupado() 
		
	method espacioOcupado() = chats.sum {chat => chat.espacioQueOcupa()}

    method enviar(mensaje,chat){
        chat.recibir(mensaje)
    }

    method agregarChat(chat){
        chats.add(chat)
    }

    method buscarTexto(texto) = chats.filter({chat => chat.contiene(texto)})

    method recibirNoti(notificacion){
        notis.add(notificacion)
    }

    method leer(chat){
        const notisDeChat = notis.filter({noti => noti.chat() == chat})
        notisDeChat.forEach({noti => noti.leerse()})
    }

    method notisSinLeer() = notis.filter({noti => not noti.leida()})
}