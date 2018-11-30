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
        return self.Nombre < other.Nombre
