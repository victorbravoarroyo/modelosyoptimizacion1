import csv
from modelo.carta import Carta

class FabricaDeCartas:
    """Fabrica de cartas crea las cartas de los mazos de cada era"""

    def crear_mazo(self, filename):

        mazo = []
        with open(filename, "r") as file:
            file_csv = csv.reader(file)
            for line in file_csv:
                nombre = str(line[0])
                Tipo = int(line[1])
                CostosTot = int(line[2])
                CMon = int(line[3])
                CLad = int(line[4])
                CCem = int(line[5])
                COro = int(line[6])
                CMad = int(line[7])
                CCer = int(line[8])
                CPap = int(line[9])
                CTel = int(line[10])
                Gratis = str(line[11])
                EMon = int(line[12])
                ELad = int(line[13])
                ECem = int(line[14])
                EOro = int(line[15])
                EMad = int(line[16])
                ECer  = int(line[17])
                EPap = int(line[18])
                ETel = int(line[19])
                EGeo = int(line[20])
                ERue = int(line[21])
                EEsc = int(line[22])
                EMil = int(line[23])
                EPto = int(line[24])

                carta = Carta(nombre, Tipo, CostosTot, CMon, CLad, CCem, COro, CMad, CCer, CPap, CTel, Gratis, EMon, ELad, ECem, EOro, EMad, ECer, EPap, ETel, EGeo, ERue, EEsc, EMil, EPto)

                mazo.append(carta)

        return mazo
