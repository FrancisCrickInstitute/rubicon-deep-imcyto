/*
 * STEP 1: imctools
 */

process IMCTOOLS {

    tag "$name"
    // label 'process_low' // 'process_medium'
    
    executor "local"
    // executor "slurm"
	// time "1h"
	// clusterOptions "--part=gpu --gres=gpu:1"

    publishDir "${params.outdir}/imctools/${name}", mode: params.publish_dir_mode,
        saveAs: { filename ->
                      if (filename.indexOf("version.txt") > 0) null
                      else filename
                }

    input:
    tuple val(name), path(mcd) //from ch_mcd
    path metadata //from ch_metadata

    output:
    tuple val(name), path("*/full_stack/*"), emit: ch_full_stack_tiff
    tuple val(name), path("*/ilastik_stack/*"), emit: ch_ilastik_stack_tiff
    tuple val(name), path("*/full_stack/191Ir_DNA1.tiff"), emit: ch_dna1
    tuple val(name), path("*/full_stack/193Ir_DNA2.tiff"), emit: ch_dna2
    tuple val(name), path("*/full_stack/100Ru_ruthenium.tiff"), emit: ch_Ru, optional: true
    tuple val(name), path("*/full_stack"), emit: ch_full_stack_dir
    path "*/*ome.tiff", emit: ch_ome_tiff
    path "*.csv"
    path "*version.txt", emit: ch_imctools_version
    val "${params.outdir}/imctools", emit: ch_imctoolsdir

    script: // This script is bundled with the pipeline, in nf-core/imcyto/bin/
    """
    run_imctools.py $mcd $metadata
    pip show imctools | grep "Version" > imctools_version.txt
    """
}



process CORRECT_SPILLOVER {

    tag "$name"
    // label 'process_low' // 'process_medium'
    
    executor "local"
    // executor "slurm"
	// time "1h"
	// clusterOptions "--part=gpu --gres=gpu:1"

    publishDir "${params.outdir}/spillover_compensated/${name}", mode: params.publish_dir_mode,

    input:
        tuple val(name), val(roi), path(full_stack_dir) //from ch_mcd
        path metadata //from ch_metadata
        path sm
        output:
        tuple val(name), path("*/full_stack/*"), emit: ch_full_stack_tiff
        tuple val(name), path("*/ilastik_stack/*"), emit: ch_ilastik_stack_tiff

    output:
        tuple val(name), val(roi), path("./spillover_compensated/*.tiff"), emit: ch_spillover_compensated_tiff

    script:
        """
        deepimcyto_correct_spillover.py --input $full_stack_dir\
                                        --outdir './spillover_compensated'\
                                        --extension '.tiff'\
                                        --spillover_matrix $sm\
                                        --metadata $metadata\
                                        --method ${params.compensation_method}
        """

}