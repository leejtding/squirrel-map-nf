# squirrel-map-nf

![](https://github.com/violafanfani/squirrel-map-nf/workflows/build/badge.svg)

bst 270 course exercise

## Test data

We downloaded the squirrel census data from `https://www.thesquirrelcensus.com/data`
on Jan 17th, 2023. 

## Configuration

- param1: this is the parameter description (default: "hello")
- ...
- paramN: this is the parameter description (default: "flow")

## Running the workflow

### Install or update the workflow

```bash
nextflow pull violafanfani/squirrel-map-nf
```

### Run the analysis

```bash
nextflow run violafanfani/squirrel-map-nf
```

## Results

- `results/analysis.txt`: file with the analysis results.
- `results/tuning.txt`: file with the parameter tuning.
- ...

## Authors

- Viola Fanfani
