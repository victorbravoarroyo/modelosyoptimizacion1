import unittest
from modelo.fabrica_de_cartas import FabricaDeCartas

class FabricaDeCartasTest(unittest.TestCase):

    def test_hay_treinta_cartas_en_era_uno(self):
        fabrica = FabricaDeCartas()
        mazo_era_1 = fabrica.crear_mazo('./modelo/cartas_era_1.csv')
        self.assertEqual(len(mazo_era_1), 30)

    def test_hay_29_cartas_en_era_2(self):
        fabrica = FabricaDeCartas()
        mazo = fabrica.crear_mazo('./modelo/cartas_era_2.csv')
        self.assertEqual(len(mazo), 29)

    def test_hay_24_cartas_en_era_3(self):
        fabrica = FabricaDeCartas()
        mazo = fabrica.crear_mazo('./modelo/cartas_era_3.csv')
        self.assertEqual(len(mazo), 24)
