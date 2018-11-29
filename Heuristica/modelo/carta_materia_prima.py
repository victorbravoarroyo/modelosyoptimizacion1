from carta import Carta

class CartaMateriaPrima(Carta):
    def __init__(self, nombre, especialidad, cantidad):
        Carta.__init__(self, nombre)
        self.especialidad = especialidad
        self.cantidad = cantidad

    def activar(self, partida):
        partida.incrementar_recursos('materia_prima', self.especialidad, self.cantidad)

    def construir_sobre(self, partida):
        partida.incrementar_recursos('materia_prima', self.especialidad, self.cantidad)