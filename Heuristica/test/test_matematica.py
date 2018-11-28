import unittest
from modelo.matematica import Matematica
 
 
def valuePlusOne(x):
    return x+1
 
class Tests(unittest.TestCase):
 
    def test(self):
        self.assertEqual( valuePlusOne(2), 3)
 
    def test_neg(self):
        self.assertEqual( valuePlusOne(-1),0)
 
if __name__ == '__main__':
    unittest.main()
