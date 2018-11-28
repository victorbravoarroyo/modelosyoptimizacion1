class Carta:
    def __init__(self, nombre, tipo, costo, efecto):
        self.nombre = nombre
        self.tipo = tipo
        self.efecto = efecto
        self.costo = costo

    def es_gratis(self):
        return not self.costo
