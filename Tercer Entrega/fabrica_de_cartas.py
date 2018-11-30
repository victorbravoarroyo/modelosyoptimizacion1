import csv

class FabricaDeCartas:
    """Fabrica de cartas crea las cartas de los mazos de cada era"""
    def crearMazo(filename):
        mazo = []
        with open(filename, "r") as file:
            file_csv = csv.reader(f)
            for line in file_csv:
                nombre = line[0]
                Tipo = line[1]
                CostosTot = line[2]
                CMon = line[3]
                CLad = line[4]
                CCem = line[5]
                COro = line[6]
                CMad = line[7]
                CCer = line[8]
                CPap = line[9]
                CTel = line[10]
                Gratis = line[11]
                EMon = line[12]
                ELad = line[13]
                ECem = line[14]
                EOro = line[15]
                EMad = line[16]
                ECer  = line[17]
                EPap = line[18]
                ETel = line[19]
                EGeo = line[20]
                ERue = line[21]
                EEsc = line[22]
                EMil = line[23]
                EPto = line[24]

                carta = Carta(nombre, Tipo, CostosTot, CMon, CLad, CCem, COro, CMad, CCer, CPap, CTel, Gratis, EMon, ELad, ECem, EOro, EMad, ECer, EPap, ETel, EGeo, ERue, EEsc, EMil, EPto)

                mazo.append(carta)

        return mazo
