cdef extern from "read_toshiba.h":
    void read_toshiba(char *in_file, float** az, float** el, float*** rtdat)

import numpy as np
cimport numpy as cnp
cimport cython

def py_read_toshiba(fname):
    az = np.zeros((120, 320), dtype=np.float32)
    cdef float[:, ::1] az_mem = az
    cdef cnp.intp_t[:] tmp = np.zeros(120, dtype=np.intp)
    cdef float** c_az = <float**> (<void*> &tmp[0])
    cdef cnp.intp_t i
    for i in range(120):
        c_az[i] = &az_mem[i, 0]

    el = np.zeros((120, 320), dtype=np.float32)
    cdef float[:, ::1] el_mem = el
    cdef float** c_el = <float**> (<void*> &tmp[0])
    for i in range(120):
        c_el[i] = &el_mem[i, 0]

    rtdat = np.zeros((120, 320, 600), dtype=np.float32)
    cdef float[:, :, ::1] rtdat_mem = rtdat
    cdef cnp.intp_t[:, ::1] tmp2 = np.zeros((120, 320), dtype=np.intp)
    cdef cnp.intp_t[:] tmp3 = np.zeros(320, dtype=np.intp)
    cdef float*** c_rtdat = <float***> (<void*> &tmp2[0, 0])
    cdef cnp.intp_t j
    for i in range(120):
        c_rtdat[i] = (<float**> &tmp3[0])
        for j in range(320):
            c_rtdat[i][j] = &rtdat_mem[i, j, 0]


    read_toshiba(fname, c_az, c_el, c_rtdat)
    return az, el, rtdat
