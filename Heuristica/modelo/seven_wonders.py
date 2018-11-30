class SevenWonders:

    def heuristica(self):
        def setearRecursosNecesarios(recNeces):
            for recurso in recNeces:
                recNeces[recurso] = 0

        # Idea Militares
        ESCUDOS_OPONENTE_ERA_1 = 1
        ESCUDOS_OPONENTE_ERA_2 = 3
        ESCUDOS_OPONENTE_ERA_3 = 5

        def calcularEscudos(cartasJugadas):
            escudos = 0
            for carta in cartasJugadas:
                escudos += carta.Especialidad['Mil']
            return escudos

        def resolverConflicto(cartasJugadasEra1, cartasJugadasEra2, cartasJugadasEra3):
            puntos = 0
            misEscudos = calcularEscudos(cartasJugadasEra1)
            if (ESCUDOS_OPONENTE_ERA_1 < misEscudos):
                puntos += 1
            elif (ESCUDOS_OPONENTE_ERA_1 > misEscudos):
                puntos -= 1

            misEscudos += calcularEscudos(cartasJugadasEra2)
            if (ESCUDOS_OPONENTE_ERA_2 < misEscudos):
                puntos += 3
            elif (ESCUDOS_OPONENTE_ERA_2 > misEscudos):
                puntos -= 1

            misEscudos += calcularEscudos(cartasJugadasEra3)
            if (ESCUDOS_OPONENTE_ERA_3 < misEscudos):
                puntos += 5
            elif (ESCUDOS_OPONENTE_ERA_3 > misEscudos):
                puntos -= 1
            return puntos

        class Carta:
            def __init__(self, nombre, Tipo, CostosTot, CMon, CLad, CCem, COro, CMad, CCer, CPap, CTel, Gratis, EMon, ELad, ECem, EOro, EMad, ECer, EPap, ETel, EGeo, ERue, EEsc, EMil, EPto):
                self.Nombre = nombre
                self.Tipo = Tipo
                self.CTot = CostosTot
                self.Costos = {'Mon': CMon, 'Lad': CLad, 'Cem': CCem,
                               'Oro': COro, 'Mad': CMad, 'Cer': CCer,
                               'Pap': CPap, 'Tel': CTel}
                self.Gratis = Gratis
                self.Especialidad = {'Mon': EMon, 'Lad': ELad, 'Cem': ECem, 'Oro': EOro,
                                     'Mad': EMad, 'Cer': ECer, 'Pap': EPap, 'Tel': ETel,
                                     'Geo': EGeo, 'Rue': ERue, 'Esc': EEsc, 'Mil': EMil,
                                     'Pto': EPto}

            def sePuedeJugar(self, recDisponibles, cartasAnteriores):
                if self.esGratis(cartasAnteriores):
                    return True

                for i in recDisponibles:
                    if (self.Costos[i] > recDisponibles[i]):
                        return False

                return True

            def esGratis(self, cartasAnteriores):
                for unaCarta in cartasAnteriores:
                    if (self.Gratis == unaCarta.Nombre):
                        return True

                if (self.CTot == 0):
                    return True
                return False

            def obetnerRecursosNecesarios(self, recNeces):
                for i in recNeces:
                    recNeces[i] += self.Costos[i]

            def __lt__(self, other):
                if self.Tipo < other.Tipo:
                    return True
                elif self.Tipo > other.Tipo:
                    return False
                else:
                    return self.ordenarSegunGratis(other)

            def entregaNecesario(self, recNeces):
                for recurso in recNeces:
                    if (recNeces[recurso] != 0):
                        if (self.Especialidad[recurso] >= recNeces[recurso]):
                            return True
                return False

            def realizarEspecilidad(self, recNeces, recDisponibles):
                for recurso in recNeces:
                    recDisponibles[recurso] += self.Especialidad[recurso]
                    recNeces[recurso] -= self.Especialidad[recurso]
                    if recNeces[recurso] < 0:
                        recNeces[recurso] = 0
                recDisponibles['Mon'] -= self.Costos['Mon']

            def ordenarSegunGratis(self, other):
                if (self.Gratis != 0) and (other.Gratis == 0):
                    return True
                elif (self.Gratis == 0) and (other.Gratis != 0):
                    return False
                else:
                    return self.ordenarCantidadCostos(other)

            def ordenarCantidadCostos(self, other):
                if self.CTot < other.CTot:
                    return True
                elif self.CTot > other.CTot:
                    return False
                else:
                    return self.ordenarPorNombre(other)

            def ordenarPorNombre(self, other):
                if self.Nombre < other.Nombre:
                    return True
                else:
                    return False

        nula = Carta('CartaNula', 6, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)

        #----- Materias Primas Era 1 -------#
        Clay = Carta('ClayPool', 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
        Stone = Carta('StonePit', 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
        ForCa = Carta('ForestCave', 2, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0)
        TimYa = Carta('TimberYard', 2, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0)
        OreVe = Carta('OreVein', 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0)
        Excav = Carta('Excavation', 2, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
        ClPit = Carta('ClayPit', 2, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
        LumYa = Carta('LumberYard', 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0)

        #----- Manufacturas Era 1 -------#
        ClasW = Carta('Classworks', 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0)
        Press = Carta('Press', 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0)
        Loom = Carta('Loom', 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0)

        #----- Civilies Era 1 ------#
        Altar = Carta('Altar', 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2)
        Baths = Carta('Baths', 3, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3)
        PawnS = Carta('Pawnshop', 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3)
        Theat = Carta('Theater', 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2)

        #----- Cientificas Era 1 ------#
        Apoth = Carta('Apothecary', 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0)
        Works = Carta('Workshop', 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0)
        Scrip = Carta('Scriptorium', 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0)

        #----- Militares Era 1 ------#
        Barra = Carta('Barracks', 4, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0)
        GTowe = Carta('GuardTower', 4, 1, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0)
        Stock = Carta('Stockade', 4, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0)

        #----- Comerciales Era 1 ------#
        Tavern = Carta('Tavern', 5, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
        WTPost = Carta('WestTradingPost', 5, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
        Market = Carta('Marketplace', 5, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)

        mazoEra1 = [Clay, Stone, ForCa, TimYa, OreVe, Excav, ClPit, LumYa, ClasW, Press, Loom, Altar, Baths, PawnS,
                    Theat, Apoth, Works, Scrip, Barra, GTowe, Stock, Tavern, WTPost, Market, nula, nula, nula, nula,
                    nula, nula]


        #----- Materias Primas Era 2 -------#
        Quarry = Carta('Quarry', 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
        BrickY = Carta('Brickyard', 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
        Sawmill = Carta('Sawmill', 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0)
        Foundary = Carta('Foundary', 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0)


        #----- Manufacturas Era 2 -------#
        Press2 = Carta('Press', 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0)
        ClassW2 = Carta('Classworks', 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0)
        Loom2 = Carta('Loom', 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0)

        #----- Civilies Era 2 ------#
        Aqued = Carta('Aqueduct', 3, 3, 0, 0, 3, 0, 0, 0, 0, 0, 'Bath', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 5)
        Temple = Carta('Temple', 3, 3, 0, 1, 0, 0, 1, 1, 0, 0, 'Altar', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3)
        Statue = Carta('Statue', 3, 3, 0, 0, 0, 2, 1, 0, 0, 0, 'Theater', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4)
        Courth = Carta('Courthouse', 3, 3, 0, 2, 0, 0, 0, 0, 0, 1, 'Scriptorium', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4)

        #----- Cientificas Era 2 ------#
        Dispen = Carta('Dispensary', 0, 3, 0, 0, 0, 2, 0, 1, 0, 0, 'Apothecary', 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0)
        School = Carta('School', 0, 2, 0, 0, 0, 0, 1, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0)
        Labor = Carta('Laboratory', 0, 3, 0, 2, 0, 0, 0, 0, 1, 0, 'Workshop', 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0)
        Library = Carta('Libary', 0, 3, 0, 0, 2, 0, 0, 0, 0, 1, 'Scriptorium', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0)

        #----- Militares Era 2 ------#
        ArcRange = Carta('ArcheryRange', 4, 3, 0, 0, 0, 1, 2, 0, 0, 0, 'Workshop', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 0)
        Training = Carta('TrainingGround', 4, 3, 0, 0, 0, 2, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 0)
        Walls = Carta('Walls', 4, 3, 0, 0, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
        Stables = Carta('Stables', 4, 3, 0, 1, 0, 1, 1, 0, 0, 0, 'Apothecary', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 0)

        #----- Comerciales Era 2 ------#
        Forum = Carta('Forum', 5, 2, 0, 2, 0, 0, 0, 0, 0, 0, 'WestTradingPost', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
        Viney = Carta('Vineyard', 5, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
        Bazar = Carta('Bazar', 5, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
        Carav = Carta('Caravansery', 5, 2, 0, 0, 0, 0, 2, 0, 0, 0, 'Marketplace', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)

        mazoEra2 = [Quarry, BrickY, Sawmill, Foundary, Press2, ClassW2, Loom2, Aqued, Temple, Statue, Courth, Dispen,
                    School, Labor, Library, ArcRange, Training, Walls, Stables, Forum, Viney, Bazar, Carav, nula, nula,
                    nula, nula, nula, nula]



        #----- Civilies Era 3 ------#
        Palace = Carta('Palace', 3, 7, 0, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 8)
        Townha = Carta('Townhall', 3, 4, 0, 0, 2, 1, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 6)
        Senate = Carta('Senate', 3, 4, 0, 0, 1, 1, 2, 0, 0, 0, 'Library', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 6)
        Panth = Carta('Pantheon', 3, 6, 0, 2, 0, 1, 0, 1, 1, 1, 'Temple', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 7)
        Gardens = Carta('Gardens', 3, 3, 0, 2, 0, 0, 1, 0, 0, 0, 'Statue', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 5)

        #----- Cientificas Era 3 ------#
        Univ = Carta('University', 0, 4, 0, 0, 0, 0, 2, 1, 1, 0, 'Library', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0)
        Obse = Carta('Observatory', 0, 4, 0, 0, 0, 2, 0, 1, 0, 1, 'Laboratory', 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0)
        Study = Carta('Study', 0, 3, 0, 0, 0, 0, 1, 0, 1, 1, 'School', 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0)
        Acad = Carta('Academy', 0, 4, 0, 0, 3, 0, 0, 1, 0, 0, 'School', 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0)
        Lod = Carta('Lodge', 0, 4, 0, 2, 0, 0, 0, 0, 1, 1, 'Dispensary', 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0)
        Univ2 = Carta('University', 0, 4, 0, 0, 0, 0, 2, 1, 1, 0, 'Library', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0)

        #----- Militares Era 3 ------#
        Arse = Carta('Arsenal', 4, 4, 0, 0, 0, 1, 2, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3, 0)
        Circus = Carta('Circus', 4, 4, 0, 0, 3, 1, 0, 0, 0, 0, 'TrainingGround', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3, 0)
        SiegW = Carta('SiegeWorkshop', 4, 4, 0, 3, 0, 0, 1, 0, 0, 0, 'Laboratory', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3, 0)
        Fort = Carta('Fortifications', 4, 4, 0, 0, 1, 3, 0, 0, 0, 0, 'Walls', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3, 0)

        #----- Comerciales Era 3 ------#
        Haven = Carta('Haven', 5, 3, 0, 0, 0, 1, 1, 0, 0, 1, 'Forum', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
        COC = Carta('ChamberOfCommerce', 5, 3, 0, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
        Light = Carta('Lighthouse', 5, 2, 0, 0, 1, 0, 0, 1, 0, 0, 'Caravansery', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)


        mazoEra3 = [Palace, Townha, Senate, Panth, Gardens, Univ, Obse, Study, Acad, Lod, Univ2, Arse, Circus, SiegW, Fort,
                    Haven, COC, Light, nula, nula, nula, nula, nula, nula]

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
            setearRecursosNecesarios(recNeces)
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
            setearRecursosNecesarios(recNeces)
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
            setearRecursosNecesarios(recNeces)
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

        puntosTotales += resolverConflicto(cartasJugadasEra1, \
                                           cartasJugadasEra2, \
                                           cartasJugadasEra3)

        print ('PUNTOS TOTALES', puntosTotales, sep = ' = ')


if __name__ == '__main__':
    SevenWonders().heuristica()
