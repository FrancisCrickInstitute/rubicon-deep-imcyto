#!/bin/bash

## LOAD MODULES
ml purge
ml Nextflow/22.04.0 #Nextflow/0.32.0 #19.04.0 #Nextflow/21.04.3 #Nextflow/21.04.0 # Nextflow/20.01.0
# ml Singularity/3.6.4
ml Singularity/2.6.0-foss-2016b
export SINGULARITY_CACHEDIR='/camp/project/proj-tracerx-lung/tctProjects/rubicon/inputs/containers/imcyto_nxf_singularity'
export NXF_SINGULARITY_CACHEDIR='/camp/project/proj-tracerx-lung/tctProjects/rubicon/inputs/containers/imcyto_nxf_singularity'
# export NXF_SINGULARITY_CACHEDIR="/camp/project/proj-tracerx-lung/tctProjects/rubicon/inputs/containers/imcyto_nxf_singularity/" ## Use locally stored Singularity containers
# export NXF_SINGULARITY_LIBRARYDIR=/camp/project/proj-tracerx-lung/tctProjects/rubicon/inputs/containers/imcyto_nxf_singularity/
# resultsdir = '/camp/project/proj-tracerx-lung/tctProjects/rubicon/tracerx/tx100/imc/outputs/deep_imcyto/results_dev_20220618_2'
# "/camp/lab/swantonc/inputs/flowcytometry/Tx100/TMA_REC/P1_TMA_REC_20190508/P1_TMA_REC_20190508.mcd"
# "/camp/lab/swantonc/inputs/flowcytometry/Tx100/TMA_REC/P1_tonsil*/*.mcd"

## RUN PIPELINE
nextflow run ./main.nf\
    --input "/camp/lab/swantonc/inputs/flowcytometry/Tx100/TMA_REC/P1_TMA_REC_20190508/P1_TMA_REC_20190508.mcd"\
    --outdir '/camp/project/proj-tracerx-lung/tctProjects/rubicon/tracerx/tx100/imc/outputs/deep_imcyto/dsl2_testing/results_seg_refactor'\
    --metadata './metadata.csv'\
    --full_stack_cppipe './assets/cppipes/full_stack_preprocessing.cppipe'\
    --segmentation_cppipe './assets/cppipes/segmentation_nuclei_linked.cppipe'\
    --ilastik_stack_cppipe './assets/cppipes/ilastik_stack_preprocessing.cppipe'\
    --compensation_tiff './assets/spillover/P1_imc*.tiff'\
    --plugins "/camp/project/proj-tracerx-lung/tctProjects/rubicon/tracerx/tx100/imc/outputs/deep_imcyto/dsl2_testing/src/rubicon-deep-imcyto/assets/plugins"\
    --skip_ilastik true \
    --email alastair.magness@crick.ac.uk\
    --dl_conda_env "/camp/lab/swantonc/working/Alastair/.conda/envs/tf"\
    --imctools_env "/camp/lab/swantonc/working/Alastair/.conda/envs/tf"\
    --md_cuda "CUDA/10.1.105"\
    --md_conda "Anaconda3"\
    --imctools_dir "/camp/project/proj-tracerx-lung/tctProjects/rubicon/tracerx/tx100/imc/outputs/deep_imcyto/dsl2_testing/results_seg_refactor/imctools"\
    --nuclear_weights_directory "/camp/project/proj-tracerx-lung/tctProjects/rubicon/tracerx/tx100/imc/outputs/deep_imcyto/dsl2_testing/weights"\
    --nuclear_ppdir "/camp/project/proj-tracerx-lung/tctProjects/rubicon/tracerx/tx100/imc/outputs/deep_imcyto/dsl2_testing/results_seg_refactor/nuclear_preprocess"\
    --nuclear_segdir "/camp/project/proj-tracerx-lung/tctProjects/rubicon/tracerx/tx100/imc/outputs/deep_imcyto/dsl2_testing/results_seg_refactor/nuclear_segmentation"\
    --segmentation_type "dilation"\
    --nuclear_dilation_radius 5\
    -profile crick\
    -resume





## "/camp/lab/swantonc/inputs/flowcytometry/Tx100/TMA_REC/P1_TMA_REC_20190508/P1_TMA_REC_20190508.mcd" \
## "/camp/lab/swantonc/inputs/flowcytometry/Katey Enfield/asb_case/Slide3_ASB/P1_Slide3_ASB_20200716_KE_HYPG/P1_Slide3_ASB_20200716_KE_HYPG.mcd"/
## "/camp/lab/swantonc/inputs/flowcytometry/Tx100/TMA_REC/P1_tonsil_start_20190508/P1_tonsil_start_20190508.mcd"
# '/camp/lab/swantonc/working/collive/rubicon/cell_segmentation/nextflow_runs/P1/20190722_Run3/mcd/*.mcd'
# "/camp/lab/swantonc/inputs/flowcytometry/Tx100/TMA_REC/P1_tonsil_start_20190508/P1_tonsil_start_20190508.mcd"