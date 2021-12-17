# wilsonte-mdi-resource-scripts
Public scripts for installing resources into AWS MDI images and instances

The [Michigan Data Interface](https://midataint.github.io/) (MDI) is a framework for developing,
installing and running a variety of HPC data analysis pipelines
and interactive R Shiny data visualization applications
within a standardized design and implementation interface.

This repository contains scripts that can be used to install shared resources,
e.g., genome files, into AWS EC2 instances that will run a public
Stage 2 Apps web server. 

## Usage

From a prompt on the AWS instance command line (NOT from within
an apps-server container):

```
cd /srv/mdi/resource-scripts
git clone https://github.com/wilsonte-umich/wilsonte-mdi-resource-scripts.git
server resource wilsonte-mdi-resource-scripts/<SCRIPT_NAME>.sh
```
