class Partida:
    def __init__(self, templo=None):
        self.ERAS = 3
        self.TURNOS = 6
        self.ESCUDOS_OPONENTE_ERA_1 = 1
        self.ESCUDOS_OPONENTE_ERA_2 = 3
        self.ESCUDOS_OPONENTE_ERA_3 = 5

        self.cartas_jugadas = [[], [], []]
        self.recursos = {
            'materia_prima': {},
            'manufactura': {}
        }
        self.incremento_de_recursos = {
            'materia_prima': {},
            'manufactura': {}
        }
        self.cantidad_cientificas = {
            'geometrica':0,
            'ruedas':0,
            'escritura':0
        }

        self.templo = templo
        self.cantidad_de_monedas = 3
        self.cantidad_de_escudos = 0

    def calcular_puntos_de_victoria(self):
        puntos_de_victoria = 0

        for era in range(len(self.cartas_jugadas)):
            for turno in range(len(self.cartas_jugadas[era])):
                carta = self.cartas_jugadas[era][turno]
                carta.activar(self)
                self.recargar_materia_prima()
                self.recargar_manufactura()
            puntos_de_victoria += self.resolver_conflicto(era)

        puntos_de_victoria += self.calcular_victoria_por_monedas()
        puntos_de_victoria += self.calcular_victoria_por_cientificas()
        return puntos_de_victoria

    def resolver_conflicto(self, era):
        if self.cantidad_de_escudos > self.ESCUDOS_OPONENTE_ERA_1 and era == 1:
            return 1
        elif self.cantidad_de_escudos > self.ESCUDOS_OPONENTE_ERA_2 and era == 2:
            return 3
        elif self.cantidad_de_escudos > self.ESCUDOS_OPONENTE_ERA_3 and era == 3:
            return 5
        elif (self.cantidad_de_escudos == self.ESCUDOS_OPONENTE_ERA_1 and era == 1) or \
             (self.cantidad_de_escudos == self.ESCUDOS_OPONENTE_ERA_2 and era == 2) or \
             (self.cantidad_de_escudos == self.ESCUDOS_OPONENTE_ERA_3 and era == 3):
             return 0
        else:
            return -1

    def calcular_victoria_por_monedas(self):
        return self.cantidad_de_monedas / 3

    def agregar_carta_en_era(self, carta, era):
        self.cartas_jugadas[era].append(carta)

    def incrementar_recursos(self, tipo, recurso, cantidad):
        if self.incremento_de_recursos[tipo].has_key(recurso):
            self.incremento_de_recursos[tipo][recurso] += cantidad
        else:
            self.incremento_de_recursos[tipo][recurso] = cantidad

    def recargar_materia_prima(self):
        for (recurso, cantidad) in self.incremento_de_recursos['materia_prima'].items():
            self.recursos['materia_prima'][recurso] = cantidad

    def recargar_manufactura(self):
        for (recurso, cantidad) in self.incremento_de_recursos['manufactura'].items():
            self.incrementar_recursos('manufactura', recurso, cantidad)

    def incrementar_cientificas(self, tipo):
        self.cantidad_cientificas[tipo] += 1

    def calcular_victoria_por_cientificas(self):
        puntos = 0
        for tipo, cantidad in self.cantidad_cientificas.items():
            puntos += cantidad ** 2

        puntos += min(self.cantidad_cientificas.values()) * 7
        return puntos
