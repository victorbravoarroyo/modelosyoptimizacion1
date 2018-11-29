from carta import Carta

class CartaManufactura(Carta):
    def __init__(self, nombre, especialidad, cantidad):
        Carta.__init__(self, nombre)
        self.especialidad = especialidad
        self.cantidad = cantidad


    def construir_sobre(self, partida):
        partida.gastar_en(self.costo)
        partida.incrementar_recursos('manufactura', self.especialidad, self.cantidad)
