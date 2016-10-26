# coding: utf-8
#
# Cookbook Name:: variant-call
# Recipe:: data
#
# Copyright (c) 2015 Jörgen Brandt, All Rights Reserved.

kgenomes_url_base = "ftp://ftp.1000genomes.ebi.ac.uk/vol1/ftp/phase3/data/HG02025/sequence_read/SRR"
kgenomes_dir = "#{node["dir"]["data"]}/#{node["kgenomes"]["dirname"]}"
annodb_hg38_dir = "#{node["dir"]["data"]}/annodb_hg38"
annodb_hg38_idlist = ["refGene.txt", "refGeneMrna.fa", "refGeneVersion.txt"]

include_recipe "chef-bioinf-worker::hg38"

# create directories
directory node["dir"]["data"]
directory kgenomes_dir
directory node["dir"]["data"]
directory annodb_hg38_dir


# download read data
node["kgenomes"]["idlist"].each { |id|
  
  url1 = "#{kgenomes_url_base}#{id}_1.filt.fastq.gz"
  url2 = "#{kgenomes_url_base}#{id}_2.filt.fastq.gz"
	
  remote_file "#{kgenomes_dir}/#{File.basename( url1 )}" do
    action :create_if_missing
    source url1
    retries 1
  end
  
  remote_file "#{kgenomes_dir}/#{File.basename( url2 )}" do
    action :create_if_missing
    source url2
    retries 1
  end

}

# download annovar db
annodb_hg38_idlist.each { |id|

  url = "http://www.openbioinformatics.org/annovar/download/hg38_#{id}"
  file = "#{annodb_hg38_dir}/#{File.basename( url )}"
  file_gz = "#{file}.gz"
  url = "#{url}.gz"
  
  remote_file file_gz do
    action :create_if_missing
    source url
    retries 1
    not_if "#{File.exists?( file_gz ) || File.exists?( file )}"
  end
  
  bash "extract_#{file_gz}" do
    code "gunzip #{file_gz}"
    cwd annodb_hg38_dir
    not_if "#{File.exists?( file )}"
  end
}
