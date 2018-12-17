name             'variant-call'
maintainer       'Jörgen Brandt'
maintainer_email 'joergen.brandt@onlinehome.de'
license          'Apache 2.0'
description      'Installs/Configures variant-call'
long_description 'Installs/Configures variant-call'
version          '0.1.3'
chef_version     '>= 12.14' if respond_to?(:chef_version)

# The `issues_url` points to the location where issues for this cookbook are
# tracked.  A `View Issues` link will be displayed on this cookbook's page when
# uploaded to a Supermarket.
#
issues_url 'https://github.com/joergen7/variant-call/issues'

# The `source_url` points to the development repository for this cookbook.  A
# `View Source` link will be displayed on this cookbook's page when uploaded to
# a Supermarket.
#
source_url 'https://github.com/joergen7/viariant-call'

depends 'chef-cuneiform', '0.1.4'
