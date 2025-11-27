class Empleado{

    const property habilidades = []
    var salud = 100
    var property rol

    method salud() = salud 

    method incapacitado() = salud < rol.saludCritica()  

    method puedeUsar(habilidad) = !self.incapacitado() && self.contiene(habilidad)

    method contiene(habilidad) =  habilidades.contains(habilidad)


    method sufrirDanio(danio){
        salud -= danio
    }

    method cumplirMision(mision){
        if(salud > 0)
            self.recibirPremio(mision)
    }

    method recibirPremio(mision) = rol.recibirPremio(mision, self)
}

class Espia{

    method saludCritica() = 15

    method recibirPremio(mision, empleado){
        const nuevasHabilidades = empleado.habilidades().addAll(mision.habilidadesRequeridas())
        empleado.habilidades(nuevasHabilidades.asSet())
    }

}

class Oficinista{

    var property estrellas

    method saludCritica() = 40 - 5 * estrellas

    method recibirPremio(mision,empleado) {
        estrellas += 1
        if(estrellas == 3)
            empleado.rol(Espia)
    }
}

class Jefe inherits Empleado{

    const subordinados = [] 

    override method contiene(habilidad) = super(habilidad) || subordinados.any({subor => subor.puedeUsar(habilidad)})

}

class Mision{

    const property habilidadesRequeridas = []
    const peligrosidad

    method serCumplidaPor(asignado){
            self.validarHabilidades(asignado)
            asignado.sufrirDanio(peligrosidad)
            asignado.cumplirMision(self)
    }
    
    method validarHabilidades(asignado){
        if(!self.cumpleConHabilidades(asignado)) 
            throw new DomainException(message="no puede cumplir mision")
    }

    method cumpleConHabilidades(asignado) = habilidadesRequeridas.all({habilidad => asignado.puedeUsar(habilidad)})


}

class Equipo {
	const empleados = []
	
	method puedeUsar(habilidad) = empleados.any({empleado => empleado.puedeUsar(habilidad)})
		
	method sufrirDanio(cantidad) {
		empleados.forEach({empleado => empleado.sufrirDanio(cantidad / 3)})
	}
	
	method cumplirMision(mision) {
		empleados.forEach({empleado => empleado.cumplirMision(mision)})
	}
}
