// enabling nextflow DSL v2
nextflow.enable.dsl=2

// import from modules
//include { plotGGPlot } from './modules/rsteps.nf'


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

    publishDir "${params.resultsDir}/tables/", pattern: "table0.csv", mode: 'copy'

    input:
        path data

    output:
        path 'table0.csv'

    """
        Rscript '${baseDir}/bin/preprocessing.r' ${data} table0.csv
    """

}

process analysisData {

    publishDir "${params.resultsDir}/tables/", pattern: "table1.csv", mode: 'copy'

    input:
        path table0

    output:
        path 'table1.csv'

    """
        Rscript '${baseDir}/bin/analysis.r' ${table0} table1.csv
    """

}


process plotCounts {

    publishDir "${params.resultsDir}/figures/", pattern: "fur_color_${parkCode}.*", mode: 'copy'

    input:
        tuple path(table), val(parkName), val(parkCode)

    output:
        tuple path("fur_color_${parkCode}.png"),path("fur_color_${parkCode}.log")

    script:
    """
        Rscript '${baseDir}/bin/plotcounts.r' ${table}  'fur_color_${parkCode}.png' "${parkName}" >> fur_color_${parkCode}.log
    """

}


process plotColor {

    publishDir "${params.resultsDir}/figures/", pattern: "fur_color_map.png", mode: 'copy'

    input:
        path table

    output:
        path 'fur_color_map.png'

    """
        Rscript '${baseDir}/bin/plotcolor.r' ${table} fur_color_map.png
    """

}


workflow {
    
    inFile = channel.from("${baseDir}/${params.rInputFile}").view()

    table0 = preprocessTable(inFile)
    table1 = analysisData(table0)

    parkName= channel.from(params.parkName).map{$it -> tuple($it, $it.replaceAll("\\s",""))}.view()
    plotCounts(table0.combine(parkName))
    plotColor(table0)

    
}
