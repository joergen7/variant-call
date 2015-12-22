# Variant Calling

A variant calling workflow.

Variant calling is a typical use case from the field of Next-Generation
Sequencing. The workflow takes as input a genetic sample from a person and
determines differences with respect to a reference human genome. Variations that
have been identified to be significant are summarized in a table and annotated.

First, the sample in FastQ format undergoes quality control. This step allows an
a priori assessment of the suitability of the sample. A low read quality or the
presence of barcodes or adapter sequences may reduce the validity of the
workflow results. Quality control with FastQC helps identifying and precluding
these error sources.

The computationally most demanding step is aligning each read in the sample to
the human reference genome. This step is performed by the read mapper Bowtie2.
The tool creates an index over each chromosome of the reference genome provided
in FastA format. Then for each reference index and each sample file in FastQ
format, read mapping is performed. The result is a table in BAM format, stating
for each mapped read the location it aligns to in the reference genome.

The BAM files are sorted individually and then merged in a way that only one BAM
file per chromosome results. Then a multiple pile-up table is created for each
of these BAM files. SAMtools is used to perform these transformations. The
multiple pile-up is the input to the actual variant detection algorithm.

Variant detection is performed using VarScan which consumes a multiple pile-up
and produces a variant table in VCF format. A significance level of 1% is
applied to identify variants.

Eventually, the variant table is annotated using Annovar which classifies
variants according to their supposed effect and whether they appear in coding or
non-coding regions of the human genome.

The
[workflow](https://github.com/joergen7/variant-call/blob/master/templates/default/variant-call.cf.erb)
is specified using the
[Cuneiform](https://github.com/joergen7/cuneiform) functional workflow language.

This repository has the form of a Chef cookbook to ensure reproducibility of the
workflow itself as well as data and tools.

## Prerequisites

Install the following packages:

- [git](https://git-scm.com/)
- [VirtualBox](https://www.virtualbox.org/)
- [Vagrant](https://www.vagrantup.com/)
- [Chef Development Kit](https://downloads.chef.io/chef-dk/)

Under Ubuntu you can install the ChefDK by entering on the command line

    sudo dpkg -i chefdk_*.deb


## Building a VM with kitchen

If you are running an Ubuntu and want to run the workflow without creating a
VM, you can run this workflow also locally (see Section Running locally). For
test purposes it is, however, recommended to set up the workflow in a VM.

To build a VM from this cookbook for the first time, change your git
base directory and enter the following:

    git clone https://github.com/joergen7/variant-call.git
    cd variant-call
    berks install
    kitchen converge
    
You can log into the newly built VM by entering

    kitchen login
    
You can drop the VM by entering

    kitchen destroy

## Building locally

This workflow can also be set up in a VM (see Section Building a VM with kitchen).
In a production environment it is, however, recommended to run the workflow locally.

To install this cookbook locally, create a directory "cookbooks", clone the cookbook
into it and install the dependencies:

    mkdir cookbooks
    cd cookbooks
    git clone https://github.com/joergen7/variant-call.git
    cd variant-call
    berks vendor ..
    cd ../..
    sudo chef-client -z -r "variant-call::default"
    
## Running the Workflow

If you installed the workflow on a VM log into the machine by typing

    kitchen login
    
Execute the workflow script by entering

    cuneiform -w /opt/data /opt/wf/variant-call.cf
    
    

