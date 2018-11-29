import unittest
from modelo.partida import Partida
from modelo.carta import Carta
from modelo.carta_manufactura import CartaManufactura
from modelo.carta_materia_prima import CartaMateriaPrima
from modelo.carta_cientifica import CartaCientifica


class PartidaTest(unittest.TestCase):
    def test_partida_sin_cartass_tiene_menos_2_victoria(self):
        partida = Partida()

        self.assertEqual(partida.calcular_puntos_de_victoria(), -2)

    def test_partida_primera_carta_press(self):
        partida = Partida()
        press = CartaManufactura('press', 'PAP', 1)
        partida.agregar_carta_en_era(press, 1)

        self.assertEqual(partida.calcular_puntos_de_victoria(), -2)

    def test_partida_segunda_carta_loom(self):
        partida = Partida()
        press = CartaManufactura('press', 'PAP', 1)
        loom = CartaManufactura('loom', 'TEL', 1)

        partida.agregar_carta_en_era(press, 1)
        partida.agregar_carta_en_era(loom, 1)

        self.assertEqual(partida.calcular_puntos_de_victoria(), -2)

    def test_partida_tercera_carta_stone_pit(self):
        partida = Partida()
        press = CartaManufactura('press', 'PAP', 1)
        loom = CartaManufactura('loom', 'TEL', 1)
        stone_pit = CartaMateriaPrima('stone pit', 'CEM', 1)

        partida.agregar_carta_en_era(press, 1)
        partida.agregar_carta_en_era(loom, 1)
        partida.agregar_carta_en_era(stone_pit, 1)

        self.assertEqual(partida.calcular_puntos_de_victoria(), -2)

    def test_partida_cuarta_carta_apothecary(self):
        partida = Partida()
        press = CartaManufactura('press', 'PAP', 1)
        loom = CartaManufactura('loom', 'TEL', 1)
        stone_pit = CartaMateriaPrima('stone pit', 'CEM', 1)
        apothecary = CartaCientifica('apothecary', 'geometrica')

        partida.agregar_carta_en_era(press, 1)
        partida.agregar_carta_en_era(loom, 1)
        partida.agregar_carta_en_era(stone_pit, 1)
        partida.agregar_carta_en_era(apothecary, 1)

        self.assertEqual(partida.calcular_puntos_de_victoria(), -1)
