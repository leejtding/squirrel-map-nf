// enabling nextflow DSL v2
nextflow.enable.dsl=2

// import from modules
include { plotGGPlot } from './modules/rsteps.nf'


process PrintHelloOnFile {

    publishDir "${params.resultsDir}", pattern: "results.txt", mode: 'copy'

    input:
        path data

    output:
        path 'results.txt'

    """
        fit.py ${data} > results.txt
    """

}


process preprocessTable {

    publishDir "${params.resultsDir}", pattern: "results.txt", mode: 'copy'

    input:
        path data

    output:
        path 'table0.csv'

    """
        Rscript '${baseDir}/bin/preprocessing.r' ${data} table0.csv
    """

}

process analysisData {

    publishDir "${params.resultsDir}", pattern: "results.txt", mode: 'copy'

    input:
        path table0

    output:
        path 'table1.csv'

    """
        Rscript '${baseDir}/bin/analysis.r' ${table0} table1.csv
    """

}


process plotCounts {

    publishDir "${params.resultsDir}", pattern: "results.txt", mode: 'copy'

    input:
        path table1

    output:
        path 'fig1.png'

    """
        Rscript '${baseDir}/bin/plotcounts.r' ${table1} fig1.png
    """

}


process plotColor {

    publishDir "${params.resultsDir}", pattern: "results.txt", mode: 'copy'

    input:
        path table1

    output:
        path 'fig2.png'

    """
        Rscript '${baseDir}/bin/plotcolor.r' ${table1} fig2.png
    """

}


workflow {
    
    inFile = channel.from("${params.rInputFile}")
    
    table0 = preprocessTable(inFile)
    table1 = analysisData(preprocessOut)
    fig1 = plotCounts(table1)
    fig2 = plotColor(table1)

    
}
