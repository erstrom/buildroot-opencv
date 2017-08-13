#############################################################
#
# sendemail
#
#############################################################

SENDEMAIL_VERSION = 1.56
SENDEMAIL_SOURCE = sendEmail-v$(SENDEMAIL_VERSION).tar.gz
SENDEMAIL_SITE = http://caspian.dotconf.net/menu/Software/SendEmail
SENDEMAIL_LICENSE = GPL-2.0
LIBFOO_DEPENDENCIES = perl

define SENDEMAIL_INSTALL_TARGET_CMDS
	$(INSTALL) $(@D)/sendEmail $(TARGET_DIR)/usr/bin
	ln -sf sendEmail $(TARGET_DIR)/usr/bin/sendemail
endef

$(eval $(generic-package))
