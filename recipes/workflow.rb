# coding: utf-8
#
# Cookbook Name:: variant-call
# Recipe:: workflow
#
# Copyright (c) 2015 Jörgen Brandt, All Rights Reserved.

# create workflow directory
directory node["dir"]["wf"]

# place workflow
template "#{node["dir"]["wf"]}/variant-call.cfl" do
  source "variant-call.cfl"
end
