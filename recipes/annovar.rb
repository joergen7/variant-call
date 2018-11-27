#
# Cookbook:: variant-call
# Recipe:: annovar
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



annovar_link = "http://www.openbioinformatics.org/annovar/download/0wgxR2rIVP/annovar.latest.tar.gz"
annovar_tar  = "#{node["dir"]["archive"]}/#{File.basename( annovar_link )}"
annovar_dir  = "#{node["dir"]["software"]}/annovar"

directory node["dir"]["archive"]
directory node["dir"]["software"]


remote_file annovar_tar do
  source annovar_link
  action :create_if_missing
  retries 1
end

bash "extract_annovar" do
  code "tar xf #{annovar_tar} -C #{node["dir"]["software"]}"
  not_if "#{Dir.exists?( annovar_dir )}"
end

link "/usr/local/bin/annotate_variation.pl" do
  to "#{annovar_dir}/annotate_variation.pl"
end

link "/usr/local/bin/convert2annovar.pl" do
  to "#{annovar_dir}/convert2annovar.pl"
end

