# coding: utf-8
#
# Cookbook Name:: variant-call
# Recipe:: tools
#
# Copyright (c) 2015 Jörgen Brandt, All Rights Reserved.


include_recipe "chef-bioinf-worker::fastqc"
include_recipe "chef-bioinf-worker::bowtie2"
include_recipe "chef-bioinf-worker::samtools"
include_recipe "chef-bioinf-worker::varscan"
include_recipe "chef-bioinf-worker::annovar"
include_recipe "chef-bioinf-worker::annodb_hg38"
include_recipe "chef-bioinf-worker::hg38"

