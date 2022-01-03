# Michigan Data Interface

The [Michigan Data Interface](https://midataint.github.io/) (MDI) 
is a framework for developing, installing and running a variety of 
HPC data analysis pipelines and interactive R Shiny data visualization 
applications within a standardized design and implementation interface.

Data analysis in the MDI is separated into 
[two stages of code execution](https://midataint.github.io/docs/analysis-flow/) 
called Stage 1 HPC **pipelines** and Stage 2 web applications (i.e., **apps**).
Collectively, pipelines and apps are referred to as **tools**.
Please read the [MDI documentation](https://midataint.github.io/) for 
more information.

## Repository contents

This repository contains scripts that can be used to 
**install shared resources**, e.g., genome files, into AWS EC2 
images/instances that will run a public Stage 2 Apps web server, 
specifically into one that has our tools suite installed:

- <https://github.com/wilsontelab/wilsontelab-mdi-tools.git>

Please see aws-mdi.md in that tools suite for complete usage information.

## Usage

From a prompt on the AWS instance command line (NOT from within
an apps-server container):

```bash
cd /srv/mdi/resource-scripts
git clone https://github.com/wilsontelab/wilsontelab-mdi-resource-scripts.git
server resource wilsontelab-mdi-resource-scripts/genomes.sh
```

## Notes

### genomes.sh

Script 'genomes.sh' downloads the entire Illumina iGenomes
file prior to extracting and keeping only certain annotation files
and discarding the large genome fasta and index files. Thus, while
the final disk usage is modest, more drive space is needed to store 
the interim files. **40 GB** proves sufficient to sequentially install 
**hg38 and mm10** onto a barebones server, but more might be needed 
to accumulate more installed genomes.
