#! /bin/sh
#$ -pe omp 2
#$ -l h_rt=24:00:00
#$ -N OUT_RECHUNK
#$ -V

export OMPI_MCA_btl=tcp,sm,self
./Rechunk.netCDF.R

wait