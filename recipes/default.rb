#
# Cookbook Name:: variant-call
# Recipe:: default
#
# Copyright (c) 2015 Jörgen Brandt, All Rights Reserved.


kgenomes_dir = "#{node.dir.data}/kgenomes"
kgenomes_url_base = "ftp://ftp.1000genomes.ebi.ac.uk/vol1/ftp/phase3/data/HG02025/sequence_read/SRR"
kgenomes_idlist = ["359188", "359195"]

include_recipe "chef-bioinf-worker::fastqc"
include_recipe "chef-bioinf-worker::bowtie2"
include_recipe "chef-bioinf-worker::samtools"
include_recipe "chef-bioinf-worker::varscan"
include_recipe "chef-bioinf-worker::annovar"
include_recipe "chef-bioinf-worker::annodb_hg38"
include_recipe "chef-bioinf-worker::hg38"
include_recipe "chef-cuneiform::default"

directory node.dir.data
directory node.dir.wf

# place workflow
template "#{node.dir.wf}/variant-call.cf" do
  source "variant-call.cf.erb"
end


# download read data
directory kgenomes_dir

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
