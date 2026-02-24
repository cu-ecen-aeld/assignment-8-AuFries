
##############################################################
#
# AESD-ASSIGNMENTS
#
##############################################################

# UPDATE TO REFERENCE ASSIGNMENT 8 CONTENTS
AESD_ASSIGNMENTS_VERSION = 'df0cde31e5ca7ed3bd3361de0eae12ce7d061753'
# Note: Be sure to reference the *ssh* repository URL here (not https) to work properly
# with ssh keys and the automated build/test system.
# Your site should start with git@github.com:
AESD_ASSIGNMENTS_SITE = 'git@github.com:cu-ecen-aeld/assignments-3-and-later-AuFries.git'
AESD_ASSIGNMENTS_SITE_METHOD = git
AESD_ASSIGNMENTS_GIT_SUBMODULES = YES

define AESD_ASSIGNMENTS_BUILD_CMDS
# 	$(MAKE) $(TARGET_CONFIGURE_OPTS) -C $(@D)/finder-app writer

	$(MAKE) $(TARGET_CONFIGURE_OPTS) -C $(@D)/server clean
	$(MAKE) $(TARGET_CONFIGURE_OPTS) -C $(@D)/server

	# kernel module build
	$(MAKE) -C $(LINUX_DIR) \
		$(LINUX_MAKE_FLAGS) \
		M=$(@D)/aesd-char-driver \
		modules
endef

# Add your writer, finder and finder-test utilities/scripts to the installation steps below
define AESD_ASSIGNMENTS_INSTALL_TARGET_CMDS
# 	$(INSTALL) -d 0755 $(@D)/conf/ $(TARGET_DIR)/etc/finder-app/conf/
# 	$(INSTALL) -m 0755 $(@D)/conf/* $(TARGET_DIR)/etc/finder-app/conf/
# 	$(INSTALL) -m 0755 $(@D)/assignment-autotest/test/assignment4/* $(TARGET_DIR)/bin
# 	$(INSTALL) -d $(TARGET_DIR)/bin/finder-app
# 	$(INSTALL) -m 0755 $(@D)/finder-app/writer $(TARGET_DIR)/bin/finder-app/
# 	$(INSTALL) -m 0755 $(@D)/finder-app/finder.sh $(TARGET_DIR)/bin/finder-app/
# 	$(INSTALL) -m 0755 $(@D)/finder-app/finder-test.sh $(TARGET_DIR)/bin/finder-app/

	# Assignment 8 char driver
	$(INSTALL) -m 0755 $(@D)/aesd-char-driver/aesdchar_load    $(TARGET_DIR)/usr/bin/
	$(INSTALL) -m 0755 $(@D)/aesd-char-driver/aesdchar_unload  $(TARGET_DIR)/usr/bin/
	$(INSTALL) -m 0755 $(@D)/aesd-char-driver/aesdchar.ko      $(TARGET_DIR)/usr/bin/
	$(INSTALL) -m 0755 $(@D)/aesd-char-driver/aesdchar-load-unload.sh  $(TARGET_DIR)/etc/init.d/S121aesdchar

	$(INSTALL) -m 0755 $(@D)/server/aesdsocket $(TARGET_DIR)/usr/bin
	$(INSTALL) -m 0755 $(@D)/server/aesdsocket-start-stop.sh $(TARGET_DIR)/etc/init.d/S99aesdsocket
endef

$(eval $(generic-package))
