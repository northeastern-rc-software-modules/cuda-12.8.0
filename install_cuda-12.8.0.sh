#!/bin/bash
#SBATCH -N 1
#SBATCH -p gpu
#SBATCH --gres=gpu:1
#SBATCH -w d1015

# Setting up the environment
source env_cuda-12.8.0.sh

# Creating the src directory for the installed application
mkdir -p $SOFTWARE_DIRECTORY/src

# Installing $SOFTWARE_NAME/$SOFTWARE_VERSION
cd $SOFTWARE_DIRECTORY/src
wget https://developer.download.nvidia.com/compute/cuda/12.8.0/local_installers/cuda_12.8.0_570.86.10_linux.run
sh ./cuda_12.8.0_570.86.10_linux.run --silent --toolkit --toolkitpath=$SOFTWARE_DIRECTORY --no-man-page

# Creating modulefile
touch $SOFTWARE_VERSION
echo "#%Module" >> $SOFTWARE_VERSION
echo "module-whatis	 \"Loads $SOFTWARE_NAME/$SOFTWARE_VERSION module." >> $SOFTWARE_VERSION
echo "" >> $SOFTWARE_VERSION
echo "This module was build on $(date)" >> $SOFTWARE_VERSION
echo "" >> $SOFTWARE_VERSION
echo "The CUDA Toolkit (https://developer.nvidia.com/cuda-toolkit) is a parallel computing platform and programming model invented by NVIDIA. It enables dramatic increases in computing performance by harnessing the power of the graphics processing unit (GPU)." >> $SOFTWARE_VERSION
echo "" >> $SOFTWARE_VERSION
echo "The script used to build this module can be found here: $GITHUB_URL" >> $SOFTWARE_VERSION
echo "" >> $SOFTWARE_VERSION
echo "To load the module, type:" >> $SOFTWARE_VERSION
echo "module load $SOFTWARE_NAME/$SOFTWARE_VERSION" >> $SOFTWARE_VERSION
echo "\"" >> $SOFTWARE_VERSION
echo "" >> $SOFTWARE_VERSION
echo "conflict	 $SOFTWARE_NAME" >> $SOFTWARE_VERSION
echo "setenv     CUDA_HOME $SOFTWARE_DIRECTORY" >> $SOFTWARE_VERSION
echo "setenv     CUDA_PATH $SOFTWARE_DIRECTORY" >> $SOFTWARE_VERSION
echo "setenv     CUDA_VERSION $SOFTWARE_VERSION" >> $SOFTWARE_VERSION
echo "prepend-path	 PATH $SOFTWARE_DIRECTORY/bin" >> $SOFTWARE_VERSION
echo "prepend-path	 MANPATH $SOFTWARE_DIRECTORY/doc/man" >> $SOFTWARE_VERSION
echo "prepend-path	 LD_LIBRARY_PATH $SOFTWARE_DIRECTORY/lib64" >> $SOFTWARE_VERSION
echo "prepend-path	 CPATH $SOFTWARE_DIRECTORY/include" >> $SOFTWARE_VERSION
echo "prepend-path	 LIBRARY_PATH $SOFTWARE_DIRECTORY/lib64" >> $SOFTWARE_VERSION

# Moving modulefile
mkdir -p $CLUSTER_DIRECTORY/modulefiles/$SOFTWARE_NAME
cp $SOFTWARE_VERSION $CLUSTER_DIRECTORY/modulefiles/$SOFTWARE_NAME/$SOFTWARE_VERSION
