library('CancerInSilico')
library(methods)

args <- commandArgs(TRUE)
arrayNum <- as.integer(args[1])
returnSize <- as.integer(args[2])

#### Set Defaults ####

initialNum <- 100
runTime <- 168
density <- 0.045
boundary <- 1
syncCycles <- FALSE
randSeed <- 0
outputIncrement <- 4
recordIncrement <- 1
timeIncrement <- 0.001
cellTypes <- c(new('CellType', name='DEFAULT', minCycle=36, cycleLength=function() 36))
cellTypeInitFreq <- c(1)
drugs <- list()
maxDeformation <- 0.1
maxTranslation <- 0.1
maxRotation <- 0.3
nG <- 28
epsilon <- 10.0
delta <- 0.2

#### Set Custom Values ####

pbs <- new('Drug', name='PBS', timeAdded=24, cycleLengthEffect=function(a,b) b)
drug_10ug <- new('Drug', name='_10ug', timeAdded=24, cycleLengthEffect=
    function(a,b) rnorm(n=1, mean=1.05*b, sd=4))
drug_100ug <- new('Drug', name='_100ug', timeAdded=24, cycleLengthEffect=
    function(a,b) rnorm(n=1, mean=1.2*b, sd=4))

allDrugs <- list(pbs, drug_10ug, drug_100ug)

dim <- c(length(allDrugs))
indexArray <- array(1:prod(dim), dim)
index <- which(indexArray==arrayNum, arr.ind=TRUE)

drugs <- c(allDrugs[index[1]])

#### Run Simulation ####

if (!is.na(returnSize)) {

    cat(as.numeric(prod(dim)))

} else {

    output <- inSilicoCellModel(initialNum=initialNum,
        runTime=runTime,
        density=density,
        boundary=boundary,
        syncCycles=syncCycles,
        randSeed=randSeed,
        modelType=modelType,
        outputIncrement=outputIncrement,
        recordIncrement=recordIncrement,
        timeIncrement=timeIncrement,
        cellTypes=cellTypes,
        cellTypeInitFreq=cellTypeInitFreq,
        drugs=drugs,
        maxDeformation=maxDeformation,
        maxTranslation=maxTranslation,
        maxRotation=maxRotation,
        nG=nG,
        epsilon=epsilon,
        delta=delta
    )

    save(output, file=paste("output_", arrayNum, ".RData", sep=""))

}
