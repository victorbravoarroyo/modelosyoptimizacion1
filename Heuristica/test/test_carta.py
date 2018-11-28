import unittest
from modelo.carta import Carta

class CartaTest(unittest.TestCase):
    def test_carta_claypool_es_gratis(self):
        carta = Carta('claypool', 'materia_prima', None, None)
        self.assertTrue(carta.es_gratis())

    def test_carta_baths_no_es_gratis(self):
        carta = Carta('baths', 'civil', {'CEM': 1}, None)
        self.assertFalse(carta.es_gratis())
