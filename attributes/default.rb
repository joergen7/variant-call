#
# Author:: Jörgen Brandt <joergen.brandt@onlinehome.de>
# Cookbook:: variant-call
# Attributes:: default
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

default["dir"]["wf"] =       "/opt/wf"
default["dir"]["data"] =     "/opt/data"
default["dir"]["archive"] =  "/opt/archive"
default["dir"]["software"] = "/opt/software"

default["kgenomes"]["dirname"] = "kgenomes"
default["kgenomes"]["idlist"] = [359188, 359195]

default["hg38"]["dirname"] = "hg38"
