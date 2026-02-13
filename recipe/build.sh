#!/bin/bash
export MAKEFLAGS="-j$(nproc)"
echo "nproc = '$(nproc)'"
if [[ "${cuda_compiler_version}" == "None" ]]
then
  export CMAKE_ARGS="${CMAKE_ARGS} -DRPU_BLAS=OpenBLAS"
  $PYTHON -m pip install . -vv --no-build-isolation
else
  export CMAKE_ARGS="${CMAKE_ARGS} -DRPU_BLAS=OpenBLAS -DUSE_CUDA=ON -DRPU_CUDA_ARCHITECTURES='75;80;86;89;90' -DCUDAHOSTCXX=$CXX -DCMAKE_CUDA_COMPILER=`which nvcc` -DCMAKE_CUDA_HOST_COMPILER=${CXX}"
  $PYTHON -m pip install . -vv --no-build-isolation
fi
