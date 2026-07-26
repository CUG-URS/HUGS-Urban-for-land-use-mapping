/** @file   mex_threads.c
 ** @brief  mex_threads MEX definition
 ** @author Bei Zhao
 **/

#include "../svm.h"
#include <mex.h>

void
mexFunction(int nout, mxArray *out[], int nin, const mxArray *in[])
{
  enum {IN_NUM = 0} ;
  enum {OUT_NUM = 0} ;
  int numThreads ;

#ifdef _OPENMP
	if(nin == 0)
  	numThreads = omp_get_max_threads() ;
	else
  	numThreads = (int)mxGetScalar(in[IN_NUM]) ;
    omp_set_num_threads(numThreads) ;
#endif
      /* optionally return loglikelihood */
  if (nout > 0) {
      // get loglikelihood of the estimated GMM
     out[OUT_NUM] = mxCreateDoubleMatrix (1,1,mxREAL);
     *((double*)mxGetData( out[OUT_NUM] ) )= numThreads;
  }

}

