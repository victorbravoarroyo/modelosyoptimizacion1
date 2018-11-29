from carta import Carta

class CartaCientifica(Carta):
    def __init__(self, nombre, tipo):
        Carta.__init__(self, nombre)
        self.tipo = tipo

    def activar(self, partida):
        partida.incrementar_cientificas(self.tipo)
