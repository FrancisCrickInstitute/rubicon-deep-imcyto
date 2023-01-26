
#!/bin/bash

## LOAD MODULES
ml purge
ml Nextflow/22.04.0
ml Singularity/3.6.4

# Define folder for deep-imcyto software containers to be stored:
export NXF_SINGULARITY_CACHEDIR='/camp/project/proj-tracerx-lung/tctProjects/rubicon/inputs/containers/deep-imcyto'


# RUN PIPELINE: katey
nextflow run ./main.nf\
    --input "/camp/project/proj-tracerx-lung/tctProjects/rubicon/PHLEX/release_testing/test_dataset/images/*/*/*.tiff"\
    --outdir '../results'\
    --metadata 'assets/metadata/run_1_metadata_test.csv'\
    --email alastair.magness@crick.ac.uk\
    --nuclear_weights_directory "/camp/project/proj-sahaie-swantonc/working/imc_segmentation/src/weights"\
    --segmentation_workflow 'simple'\
    --nuclear_dilation_radius 5\
    --preprocess_method 'hotpixel'\
    --n_neighbours 5\
    -profile crick\
    -w '/camp/project/proj-tracerx-lung/txscratch/rubicon/deep_imcyto/work'\
    # -resume