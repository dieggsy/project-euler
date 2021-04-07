gsl_vector gsl_matrix_diag(matrix m) {
    gsl_vector_int_view view = gsl_matrix_int_diagonal(m);
    gsl_vector_int *vec = gsl_vector_int_alloc(view.vector.size);
    memcpy(vec,&view.vector,sizeof(gsl_vector_int));
    return(vec);
}

C_word gsl_make_rect(double x, double y) {
    /* gsl_complex *zp = (gsl_complex *)malloc(sizeof(gsl_complex)); */
    gsl_complex z = gsl_complex_rect(x,y);
    /* memcpy(zp,&z,sizeof(gsl_complex)); */

    C_return(scheme_make_rect(GSL_REAL(z),GSL_IMAG(z)));
}
