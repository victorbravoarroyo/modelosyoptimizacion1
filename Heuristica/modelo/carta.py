from modo_construccion import ModoConstruccion

class Carta:
    def __init__(self, nombre, costo={}, modo=ModoConstruccion()):
        self.nombre = nombre
        self.costo = costo
        self.modo = modo

    def activar(self, partida):
        self.modo.activar(self, partida)
