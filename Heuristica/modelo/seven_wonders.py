from modelo.carta import Carta
from modelo.fabrica_de_cartas import FabricaDeCartas

ESCUDOS_OPONENTE_ERA_1 = 1
ESCUDOS_OPONENTE_ERA_2 = 3
ESCUDOS_OPONENTE_ERA_3 = 5

class SevenWonders:

    def setearRecursosNecesarios(self, recNeces):
        for recurso in recNeces:
            recNeces[recurso] = 0

    def calcularEscudos(self, cartasJugadas):
        escudos = 0
        for carta in cartasJugadas:
            escudos += carta.Especialidad['Mil']
        return escudos

    def resolverConflicto(self, cartasJugadasEra1, cartasJugadasEra2, cartasJugadasEra3):
        puntos = 0
        misEscudos = self.calcularEscudos(cartasJugadasEra1)
        if (ESCUDOS_OPONENTE_ERA_1 < misEscudos):
            puntos += 1
        elif (ESCUDOS_OPONENTE_ERA_1 > misEscudos):
            puntos -= 1

        misEscudos += self.calcularEscudos(cartasJugadasEra2)
        if (ESCUDOS_OPONENTE_ERA_2 < misEscudos):
            puntos += 3
        elif (ESCUDOS_OPONENTE_ERA_2 > misEscudos):
            puntos -= 1

        misEscudos += self.calcularEscudos(cartasJugadasEra3)
        if (ESCUDOS_OPONENTE_ERA_3 < misEscudos):
            puntos += 5
        elif (ESCUDOS_OPONENTE_ERA_3 > misEscudos):
            puntos -= 1
        return puntos

    def heuristica(self):

        fabrica = FabricaDeCartas()
        mazoEra1 = fabrica.crear_mazo('./modelo/cartas_era_1.csv')
        mazoEra2 = fabrica.crear_mazo('./modelo/cartas_era_2.csv')
        mazoEra3 = fabrica.crear_mazo('./modelo/cartas_era_3.csv')


        cartasJugadasEra1 = []
        cartasJugadasEra2 = []
        cartasJugadasEra3 = []


        recursos = {'Mon' : 3, 'Lad': 0, 'Cem': 0, 'Oro': 0, 'Mad': 0, 'Cer': 0,
                    'Pap': 0, 'Tel': 0}

        recNeces = {'Lad': 0, 'Cem': 0, 'Oro': 0, 'Mad': 0, 'Cer': 0,
                    'Pap': 0, 'Tel': 0}

        """ClasW, Press, Loom"""
        for i in cartasJugadasEra1:
            i.realizarEspecilidad(recNeces, recursos)

        mazoEra1 = sorted(mazoEra1)

        while len(cartasJugadasEra1) < 6:
            self.setearRecursosNecesarios(recNeces)
            for unaCarta in mazoEra1:
                if (unaCarta.Tipo == 0):
                    if unaCarta.sePuedeJugar(recursos, cartasJugadasEra2):
                        cartaJugada = unaCarta
                        mazoEra1.remove(unaCarta)
                        cartasJugadasEra1.append(cartaJugada)
                        break
                    else:
                        unaCarta.obetnerRecursosNecesarios(recNeces)
                    #break
                elif (unaCarta.Tipo == 1) or (unaCarta.Tipo == 2):
                    if unaCarta.entregaNecesario(recNeces):
                        if unaCarta.sePuedeJugar(recursos, cartasJugadasEra2):
                            cartaJugada = unaCarta
                            mazoEra1.remove(unaCarta)
                            cartasJugadasEra1.append(cartaJugada)
                            cartaJugada.realizarEspecilidad(recNeces, recursos)
                            break

        print ('---- ERA 1 -------')
        for i in cartasJugadasEra1:
            print (i.Nombre)
        print ('---- FIN ERA 1 -------')

        mazoEra2 = sorted(mazoEra2)
        while len(cartasJugadasEra2) < 6:
            self.setearRecursosNecesarios(recNeces)
            for unaCarta in mazoEra2:
                if (unaCarta.Tipo == 0):
                    if unaCarta.sePuedeJugar(recursos, cartasJugadasEra1):
                        cartaJugada = unaCarta
                        mazoEra2.remove(unaCarta)
                        cartasJugadasEra2.append(cartaJugada)
                        break
                    else:
                        unaCarta.obetnerRecursosNecesarios(recNeces)
                    #break
                elif (unaCarta.Tipo == 1) or (unaCarta.Tipo == 2):
                    if unaCarta.entregaNecesario(recNeces):
                        if unaCarta.sePuedeJugar(recursos, cartasJugadasEra1):
                            cartaJugada = unaCarta
                            mazoEra2.remove(unaCarta)
                            cartasJugadasEra2.append(cartaJugada)
                            cartaJugada.realizarEspecilidad(recNeces, recursos)
                            break
                else:
                    if unaCarta.sePuedeJugar(recursos, cartasJugadasEra1):
                        cartaJugada = unaCarta
                        mazoEra2.remove(unaCarta)
                        cartasJugadasEra2.append(cartaJugada)
                        cartaJugada.realizarEspecilidad(recNeces, recursos)
                        break

        print ('---- ERA 2 -------')
        for i in cartasJugadasEra2:
            print (i.Nombre)
        print ('---- FIN ERA 2 -------')


        mazoEra3 = sorted(mazoEra3)
        while len(cartasJugadasEra3) < 6:
            self.setearRecursosNecesarios(recNeces)
            for unaCarta in mazoEra3:
                if (unaCarta.Tipo == 0):
                    if unaCarta.sePuedeJugar(recursos, cartasJugadasEra2):
                        cartaJugada = unaCarta
                        mazoEra3.remove(unaCarta)
                        cartasJugadasEra3.append(cartaJugada)
                        break
                    else:
                        unaCarta.obetnerRecursosNecesarios(recNeces)
                    #break
                elif (unaCarta.Tipo == 1) or (unaCarta.Tipo == 2):
                    if unaCarta.entregaNecesario(recNeces):
                        if unaCarta.sePuedeJugar(recursos, cartasJugadasEra2):
                            cartaJugada = unaCarta
                            mazoEra3.remove(unaCarta)
                            cartasJugadasEra3.append(cartaJugada)
                            cartaJugada.realizarEspecilidad(recNeces, recursos)
                            break
                else:
                    if unaCarta.sePuedeJugar(recursos, cartasJugadasEra2):
                        cartaJugada = unaCarta
                        mazoEra3.remove(unaCarta)
                        cartasJugadasEra3.append(cartaJugada)
                        cartaJugada.realizarEspecilidad(recNeces, recursos)
                        break

        print ('---- ERA 3 -------')
        for i in cartasJugadasEra3:
            print (i.Nombre)
        print ('---- FIN ERA 3 -------')


        simbolos = {'Geo': 0, 'Rue': 0, 'Esc': 0}

        for unSimbolo in simbolos:
            for unaCarta in cartasJugadasEra1:
                simbolos[unSimbolo] += unaCarta.Especialidad[unSimbolo]
            for unaCarta in cartasJugadasEra2:
                simbolos[unSimbolo] += unaCarta.Especialidad[unSimbolo]
            for unaCarta in cartasJugadasEra3:
                simbolos[unSimbolo] += unaCarta.Especialidad[unSimbolo]

        for unSimbolo in simbolos:
            print (unSimbolo, simbolos[unSimbolo], sep = ' = ')

        puntosCartas = 0
        for unaCarta in cartasJugadasEra1:
            puntosCartas += unaCarta.Especialidad['Pto']
        for unaCarta in cartasJugadasEra2:
            puntosCartas += unaCarta.Especialidad['Pto']
        for unaCarta in cartasJugadasEra3:
            puntosCartas += unaCarta.Especialidad['Pto']

        print ('Puntos por cartas ', puntosCartas, sep = ' = ')

        puntosPorMonedas = recursos['Mon'] // 3
        print ('Puntos por monedas', puntosPorMonedas, sep = ' = ')


        puntosTotales = 0
        for unSim in simbolos:
            puntosTotales +=  simbolos[unSim]**2

        puntosTrioDeCartas = 7*min(simbolos['Geo'], simbolos['Rue'], simbolos['Esc'])
        print ('Puntos trio simbolos', puntosTrioDeCartas, sep = ' = ')

        puntosTotales += puntosCartas + puntosTrioDeCartas

        puntosTotales += self.resolverConflicto(cartasJugadasEra1, \
                                           cartasJugadasEra2, \
                                           cartasJugadasEra3)

        print ('PUNTOS TOTALES', puntosTotales, sep = ' = ')
