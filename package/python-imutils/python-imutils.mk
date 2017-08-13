################################################################################
#
# python-imutils
#
################################################################################

PYTHON_IMUTILS_VERSION = 0.4.3
PYTHON_IMUTILS_SOURCE = imutils-$(PYTHON_IMUTILS_VERSION).tar.gz
PYTHON_IMUTILS_SITE = https://pypi.python.org/packages/a0/cf/5f19a892b73c1992b83fbe747556984e68b2c04a3967ab52ef093d89f929
PYTHON_IMUTILS_SETUP_TYPE = distutils
PYTHON_IMUTILS_LICENSE = UNKNOWN

$(eval $(python-package))
