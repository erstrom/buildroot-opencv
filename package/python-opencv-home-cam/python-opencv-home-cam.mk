################################################################################
#
# python-opencv-home-cam
#
################################################################################

PYTHON_OPENCV_HOME_CAM_VERSION = 7eab4c55dbe424d612418c824bf9316ce5f384e2
PYTHON_OPENCV_HOME_CAM_SOURCE = opencv-home-cam-$(PYTHON_OPENCV_HOME_CAM_VERSION).tar.gz
PYTHON_OPENCV_HOME_CAM_SITE = $(call github,erstrom,opencv-home-cam,$(PYTHON_OPENCV_HOME_CAM_VERSION))
PYTHON_OPENCV_HOME_CAM_SETUP_TYPE = setuptools
PYTHON_OPENCV_HOME_CAM_LICENSE = MIT
PYTHON_OPENCV_HOME_CAM_DEPENDENCIES = python-imutils

ifeq ($(BR2_PACKAGE_PYTHON_OPENCV_HOME_CAM_SEND_EMAIL_ACTION), y)
define PYTHON_OPENCV_HOME_CAM_INSTALL_SENDEMAIL_ACTION
	( \
		mkdir -p $(TARGET_DIR)/etc/opencv-home-cam; \
		cp $(@D)/example-actions/sendemail.sh $(TARGET_DIR)/etc/opencv-home-cam/sendemail.sh; \
		sed -i s/FROM_ADDR=\".*\"/FROM_ADDR=\"$(BR2_PACKAGE_PYTHON_OPENCV_HOME_CAM_SEND_EMAIL_ACTION_FROM_ADDR)\"/ \
			$(TARGET_DIR)/etc/opencv-home-cam/sendemail.sh; \
		sed -i s/TO_ADDR=\".*\"/TO_ADDR=\"$(BR2_PACKAGE_PYTHON_OPENCV_HOME_CAM_SEND_EMAIL_ACTION_TO_ADDR)\"/ \
			$(TARGET_DIR)/etc/opencv-home-cam/sendemail.sh; \
		sed -i s/SMTP_SERVER=\".*\"/SMTP_SERVER=\"$(BR2_PACKAGE_PYTHON_OPENCV_HOME_CAM_SEND_EMAIL_SMTP_SERVER)\"/ \
			$(TARGET_DIR)/etc/opencv-home-cam/sendemail.sh; \
		sed -i s/SMTP_PASSWD=\".*\"/SMTP_PASSWD=\"$(BR2_PACKAGE_PYTHON_OPENCV_HOME_CAM_SEND_EMAIL_SMTP_PASSWD)\"/ \
			$(TARGET_DIR)/etc/opencv-home-cam/sendemail.sh; \
		mkdir -p $(TARGET_DIR)/etc/opencv-home-cam/haar-cascades; \
		cp $(@D)/example-configs/config-haar-face-detection.ini \
			$(TARGET_DIR)/etc/opencv-home-cam/config.ini; \
		cp $(@D)/haar-cascades/haarcascade_frontalface_default.xml \
			$(TARGET_DIR)/etc/opencv-home-cam/haar-cascades; \
		sed -i s/cascade=.*/cascade=\\/etc\\/opencv-home-cam\\/haar-cascades\\/haarcascade_frontalface_default\.xml/ \
			$(TARGET_DIR)/etc/opencv-home-cam/config.ini; \
		sed -i s/command=.*/command=\\/etc\\/opencv-home-cam\\/sendemail\.sh/ \
			$(TARGET_DIR)/etc/opencv-home-cam/config.ini; \
		sed -i s/recording_dir=.*/recording_dir=\\/root\\/opencv-home-cam-recordings/ \
			$(TARGET_DIR)/etc/opencv-home-cam/config.ini; \
		mkdir -p $(TARGET_DIR)/root/opencv-home-cam-recordings; \
	)
endef
endif

define PYTHON_OPENCV_HOME_CAM_INSTALL_LOGGING_CFG
	( \
		mkdir -p $(TARGET_DIR)/etc/opencv-home-cam; \
		mkdir -p $(TARGET_DIR)/root/opencv-home-cam-logs; \
		cp $(@D)/example-configs/logging.ini \
			$(TARGET_DIR)/etc/opencv-home-cam; \
		sed -i s/args=\(\'logs.*/args=\(\'\\/root\\/opencv-home-cam-logs\\/log\',\'w\',100000,100\)/ \
			$(TARGET_DIR)/etc/opencv-home-cam/logging.ini; \
	)
endef

define PYTHON_OPENCV_HOME_CAM_INSTALL_EXTRA
	$(PYTHON_OPENCV_HOME_CAM_INSTALL_LOGGING_CFG)
	$(PYTHON_OPENCV_HOME_CAM_INSTALL_SENDEMAIL_ACTION)
endef

PYTHON_OPENCV_HOME_CAM_POST_INSTALL_TARGET_HOOKS += PYTHON_OPENCV_HOME_CAM_INSTALL_EXTRA

define PYTHON_OPENCV_HOME_CAM_INSTALL_INIT_SYSV
	$(INSTALL) -D -m 755 package/python-opencv-home-cam/S60opencv-home-cam \
		$(TARGET_DIR)/etc/init.d
endef

$(eval $(python-package))
