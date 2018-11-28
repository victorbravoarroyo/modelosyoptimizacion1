#Era III:
#puede hacerse las 6 de forma gratuita
#    (usa LibraryX2, Laboratory, SchoolX2, Dispensary)

#Era II:
#hay 3/4 que pueden ser gratis[Disp,Lab,Lib]
#    (usa Apothecary, Workshop, Scriptorium)
#    SCHOOL: 1 madera y 1 papiro

#Era I:
#    APOTHECARY: 1 Tela
#    WORKSHOP: 1 Ceramica
#    SCRIPTORIUM: 1 Papiro

#Definitiva: necesitaria 1 Tela, 1 Madera(E2), 1 Ceramica y 1 Papiro
#    Podria comprar solo 1 recurso.
#    Era 1: Classwork(1Cer) - Press (1 Pap) - Loom (1Tela). Todas Gratis

#    Era II: Sawmill (2 Maderas).

#Nombre, Tipo, Costos..., Gratis, Especialidad...
    #Costos: Monedas, Lad, Cem, Oro, Mad, Cer, Pap, Tel.
    #Especi: Monedas, Lad, Cem, Oro, Mad, Cer, Pap, Tel, Mil, Ptos.    
class Carta:
    def __init__(self, nombre, Tipo, CostosTot, CMon, CLad, CCem, COro, CMad, CCer, CPap, CTel, Gratis, EMon, ELad, ECem, EOro, EMad, ECer, EPap, ETel, EGeo, ERue, EEsc, EMil, EPto):
        self.Nombre = nombre
        self.Tipo = Tipo
        self.CTot = CostosTot
        self.CMon = CMon
        self.CLad = CLad
        self.CCem = CCem
        self.COro = COro
        self.CMad = CMad
        self.CCer = CCer
        self.CPap = CPap
        self.CTel = CTel
        self.Gratis = Gratis
        self.EMon = CMon
        self.ELad = CLad
        self.ECem = CCem
        self.EOro = COro
        self.EMad = CMad
        self.ECer = CCer
        self.EPap = CPap
        self.ETel = CTel
        self.EGeo = EGeo
        self.ERue = ERue
        self.EEsc = EEsc
        self.EMil = EMil
        self.EPto = EPto

    def __lt__(self, other):
        if self.Tipo < other.Tipo:
            return True
        elif self.Tipo > other.Tipo:
            return False
        else:
            return self.ordenarSegunGratis(other)

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
      
#----- Materias Primas Era 1 -------#
Clay = Carta('ClayPool', 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
Stone = Carta('StonePit', 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
ForCa = Carta('ForestCave', 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0)
TimYa = Carta('TimberYard', 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0)
OreVe = Carta('OreVein', 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0)
Excav = Carta('Excavation', 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
ClPit = Carta('ClayPit', 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
LumYa = Carta('LumberYard', 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0)

#----- Manufacturas Era 1 -------#
ClasW = Carta('Classworks', 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0)
Press = Carta('Press', 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0)
Loom = Carta('Loom', 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0)

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
            Theat, Apoth, Works, Scrip, Barra, GTowe, Stock, Tavern, WTPost, Market]
#for i in mazoEra1:
#    print (i.Nombre)
#print('--------------')
#mazoEra1 = sorted(mazoEra1)
#for i in mazoEra1:
#    print (i.Nombre)
#print('--------------')
#print(len(mazoEra1))



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
            School, Labor, Library, ArcRange, Training, Walls, Stables, Forum, Viney, Bazar, Carav]
#for i in mazoEra2:
#    print (i.Nombre)
#print('--------------')
#mazoEra2 = sorted(mazoEra2)
#for i in mazoEra2:
#    print (i.Nombre)
#print('--------------')
#print(len(mazoEra2))




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
Lod = Carta('Lodege', 0, 4, 0, 2, 0, 0, 0, 0, 1, 1, 'Dispensary', 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0)
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
            Haven, COC, Light]

for i in mazoEra3:
    print (i.Nombre)
print('--------------')
mazoEra3 = sorted(mazoEra3)
for i in mazoEra3:
    print (i.Nombre)
print('--------------')
print(len(mazoEra3))
