import numpy as np
from py_read_toshiba import py_read_toshiba

fname='20190920-170035.all.10000000.dat'
az, el, rtdat = py_read_toshiba(fname.encode("ascii"))

print("az", az.mean())
print("el", el.mean())
print("rtdat", rtdat.mean())
