# coding: utf-8
#
# Cookbook Name:: variant-call
# Recipe:: default
#
# Copyright (c) 2015 Jörgen Brandt, All Rights Reserved.



include_recipe "chef-cuneiform::default"

include_recipe "variant-call::tools"
include_recipe "variant-call::data"
include_recipe "variant-call::workflow"



