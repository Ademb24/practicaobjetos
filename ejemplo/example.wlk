class Enfermedad {
  var celulasAmenazadas

  method celulasAmenazadas() = celulasAmenazadas
}

class Persona {
  const enfermedades = []
  var temperatura
  var celulas

  method enfermedades() = enfermedades

  method aumentarTemperatura(unosGrados){
    temperatura = 45.min(temperatura + unosGrados)
  }

  method contraerEnfermedad(enfermedad){
    enfermedades.add(enfermedad)
  }

  method destruirCelulas(cantidadCelulas){
    celulas = celulas - cantidadCelulas
  }

  method cantidadCelulas() = celulas

  method tiene(enfermedad){
    enfermedades.contains(enfermedad)
  }

  method vivirUnDia(){
    enfermedades.foreach({ enfermedad => enfermedad.afectar(self)})
  }

  method vivir(dias){
    dias.times({ _ => self.vivirUnDia()})
  }

  method enfermedadesAgresivas() = enfermedades.filter({enfermedad => enfermedad.esAgresiva(self)})

  method cantidadCelulasAfectadasPorEnfermedadesAgresivas() = self.enfermedadesAgresivas().sum(
    {enfermedad => enfermedad.celulasAmenazadas()})

}

class EnfermedadInfecciosa inherits Enfermedad {
  method afectar(unaPersona){
    unaPersona.aumentarTemperatura(celulasAmenazadas/1000)
  }

  method reproducirse(){
    celulasAmenazadas *= 2
  }

  method esArgesiva(unaPersona) = 
    celulasAmenazadas > unaPersona.cantidadCelulas()*0.1


}

class EnfermedadAutoinmune inherits Enfermedad{
  var cantidadDeVecesQueAfecto = 0

  method afectar(unaPersona){
    unaPersona.destruirCelulas(celulasAmenazadas)
    self.aumentarVecesQueAfecto()
  }

  method aumentarVecesQueAfecto(){
    cantidadDeVecesQueAfecto += 1
  }

  method esAgresiva(unaPersona) = cantidadDeVecesQueAfecto > 30
}