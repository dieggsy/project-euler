#include <string.h>
#include <gsl/gsl_matrix_int.h>
#include <gsl/gsl_complex_math.h>

gsl_vector_int* gsl_matrix_diag(gsl_matrix_int *m) {
    gsl_vector_int_view view = gsl_matrix_int_diagonal(m);
    gsl_vector_int *vec = gsl_vector_int_alloc(view.vector.size);
    memcpy(vec,&view.vector,sizeof(gsl_vector_int));
    return(vec);
}

gsl_complex* gsl_make_rect(double x, double y) {
    gsl_complex *zp = (gsl_complex *)malloc(sizeof(gsl_complex));
    gsl_complex z = gsl_complex_rect(x,y);
    memcpy(zp,&z,sizeof(gsl_complex));
    return zp;
}
