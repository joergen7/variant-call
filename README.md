# Variant Calling

This workflow calls variants in a sequence sample by aligning it to a reference
genome, identifying variants and annotating them. It reimplements a publication
by [Koboldt et al. 2013](http://www.ncbi.nlm.nih.gov/pmc/articles/PMC4278659/pdf/nihms550771.pdf).

A detailed description can be found on the [Cuneiform website](http://cuneiform-lang.org/examples/2016/01/12/variant-call/). This cookbook installs all necessary tools, downloads all necessary data, sets up Cuneiform, and places the [workflow](https://github.com/joergen7/variant-call/blob/master/templates/default/variant-call.cf.erb) in a predetermined location. The cookbook can be run on any system in a virtual machine.

## Requirements

### Platforms

- Ubuntu

### Chef

- Chef 12.14+

### Cookbooks

- chef-cuneiform
  - chef-rebar3
    -erlang
      - build-essential
      - mingw
      - seven_zip
      - windows
      - yum-epel
      - yum-erlang_solutions

## Recipes

- `variant-call::default` updates the apt package index and runs `variant-call::tools`, `variant-call::data`, and `variant-call::workflow`
- `variant-call::tools` installs [FastQC](https://www.bioinformatics.babraham.ac.uk/projects/fastqc/), [Bowtie 2](http://bowtie-bio.sourceforge.net/bowtie2/index.shtml), [SAMtools](http://samtools.sourceforge.net/), [VarScan](http://varscan.sourceforge.net/), and includes the recipe `variant-call::annovar`.
- `variant-call::annovar` installs [ANNOVAR](http://annovar.openbioinformatics.org/en/latest/)
- `variant-call::data` includes the recipes `variant-call::kgenomes`, `variant-call::hg38`, and `variant-call::annovar-db`
- `variant-call::kgenomes` downloads two samples from the [1000 Genomes Project](http://www.internationalgenome.org/)
- `variant-call::hg38` downloads the HG38 Human reference genome from [UCSC](http://hgdownload.cse.ucsc.edu/downloads.html)
- `variant-call::annovar-db` downloads the HG38 gene annotation index database for ANNOVAR
- `variant-call::workflow` places the Cuneiform variant calling workflow in `/opt/wf`

## Running the Workflow

If you set up the workflow via `kitchen converge`, log into the machine by typing

    kitchen login
    
Execute the workflow script by entering

    cuneiform -d /opt/data /opt/wf/variant-call.cf
    
## Authors

- Jörgen Brandt ([@joergen7](https://github.com/joergen7/)) [joergen.brandt@onlinehome.de](mailto:joergen.brandt@onlinehome.de)

## License

[Apache 2.0](https://www.apache.org/licenses/LICENSE-2.0.html)