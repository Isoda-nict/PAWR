from Cython.Distutils import build_ext
from Cython.Build import cythonize
from setuptools import setup, Extension
import numpy as np

extention = [
    Extension(
        "py_read_toshiba",
        sources=["py_read_toshiba.pyx", "read_toshiba.c"],
        include_dirs = [np.get_include()],
    )
]

setup(
    name="py_read_toshiba",
    ext_modules=cythonize(extention),
    cmdclass={'build_ext': build_ext}
)
