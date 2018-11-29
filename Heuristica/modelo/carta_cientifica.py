from carta import Carta
from modo_construccion import ModoConstruccion

class CartaCientifica(Carta):
    def __init__(self, nombre, tipo, costo={}, modo=ModoConstruccion()):
        Carta.__init__(self, nombre, costo, modo)
        self.tipo = tipo

    def construir_sobre(self, partida):
        partida.gastar_en(self.costo)
        partida.incrementar_cientificas(self.tipo)
