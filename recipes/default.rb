#
# Cookbook:: variant-call
# Recipe:: default
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


# refresh package sources
bash "apt-get_update" do
    code "apt-get update"
end

include_recipe "chef-cuneiform::default"
include_recipe "variant-call::tools"
include_recipe "variant-call::data"
include_recipe "variant-call::workflow"



