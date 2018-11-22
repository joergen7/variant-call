#
# Cookbook:: variant-call
# Recipe:: kgenomes
#
# Copyright:: 2015-2018 Jörgen Brandt
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

kgenomes_url_base = "ftp://ftp.1000genomes.ebi.ac.uk/vol1/ftp/phase3/data/HG02025/sequence_read/SRR"
kgenomes_dir = "#{node["dir"]["data"]}/#{node["kgenomes"]["dirname"]}"

directory node["dir"]["data"]
directory kgenomes_dir

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