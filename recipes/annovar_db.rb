#
# Cookbook:: variant-call
# Recipe:: annovar-db
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

annodb_hg38_dir = "#{node["dir"]["data"]}/annovar"
annodb_hg38_idlist = ["refGene.txt", "refGeneMrna.fa", "refGeneVersion.txt"]

directory node["dir"]["data"]
directory annodb_hg38_dir
directory "#{annodb_hg38_dir}/db"

annodb_hg38_idlist.each { |id|

  url = "http://www.openbioinformatics.org/annovar/download/hg38_#{id}"
  file = "#{annodb_hg38_dir}/db/#{File.basename( url )}"
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

bash "bundle_annodb" do
  code "tar cvf hg38db.tar db; rm -rf db"
  cwd annodb_hg38_dir
  not_if File.exists?( "hg38db.tar" )
end

