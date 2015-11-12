# coding: utf-8
#
# Cookbook Name:: variant-call
# Recipe:: data
#
# Copyright (c) 2015 Jörgen Brandt, All Rights Reserved.

kgenomes_dir = "#{node.dir.data}/kgenomes"
kgenomes_url_base = "ftp://ftp.1000genomes.ebi.ac.uk/vol1/ftp/phase3/data/HG02025/sequence_read/SRR"
kgenomes_idlist = ["359188", "359195"]

# create directories
directory node.dir.data
directory kgenomes_dir

# download read data
kgenomes_idlist.each { |id|
  
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

