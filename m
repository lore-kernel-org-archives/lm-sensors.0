From: Andre Prendel <andre.prendel@gmx.de>
Date: Wed, 31 Mar 2010 20:05:06 +0000
Subject: [lm-sensors] [RFC PATCH v3 2/2] Add auto config script
Message-Id: <20100331200506.GC2002@andre-laptop>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

This shell script searches for suitable configuration files due to
systems DMI data and installs them.
---

Index: sensors/prog/detect/install.sh
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ sensors/prog/detect/install.sh	2010-03-31 22:00:20.015242241 +0200
@@ -0,0 +1,58 @@
+#!/bin/bash
+
+SYSFS_PATH=3D/sys/class/dmi/id
+CONF_PATH=3D/var/lib/sensors/conf
+INSTALL_FILE=3D/etc/sensors.d/automobo.conf
+
+BOARD_VENDOR=3D`cat $SYSFS_PATH/board_vendor`
+BOARD_NAME=3D`cat $SYSFS_PATH/board_name`
+BOARD_VERSION=3D`cat $SYSFS_PATH/board_version`
+SYS_VENDOR=3D`cat $SYSFS_PATH/sys_vendor`
+PRODUCT_NAME=3D`cat $SYSFS_PATH/product_name`
+PRODUCT_VERSION=3D`cat $SYSFS_PATH/product_version`
+
+# only for testing
+#BOARD_VENDOR=3DFujitsu
+#BOARD_NAME=D2312C1
+#BOARD_VERSION=3D1.0
+#SYS_VENDOR=3DFujitsu
+#PRODUCT_NAME=D2312D2
+#PRODUCT_VERSION=3D2.0
+
+SEARCH_BOARD_VERSION=3D$CONF_PATH"/"$BOARD_VENDOR"_"$BOARD_NAME"_"$BOARD_V=
ERSION
+SEARCH_BOARD=3D$CONF_PATH"/"$BOARD_VENDOR"_"$BOARD_NAME
+SEARCH_SYS_VERSION=3D$CONF_PATH"/"$SYS_VENDOR"_"$PRODUCT_NAME"_"$PRODUCT_V=
ERSION
+SEARCH_SYS=3D$CONF_PATH"/"$SYS_VENDOR"_"$PRODUCT_NAME
+
+echo "Looking for config: $SEARCH_BOARD_VERSION"
+if [ -h "$SEARCH_BOARD_VERSION" ]; then
+    echo "Found suitable config"
+    cp -f $SEARCH_BOARD_VERSION $INSTALL_FILE
+    exit 0
+fi
+
+echo "Looking for config: $SEARCH_BOARD"
+if [ -h "$SEARCH_BOARD" ]; then
+    echo "Found suitable config"
+    cp -f $SEARCH_BOARD $INSTALL_FILE
+    exit 0
+fi
+
+echo "Looking for config: $SEARCH_SYS_VERSION"
+if [ -h "$SEARCH_SYS_VERSION" ]; then
+    echo "Found suitable config"
+    cp -f $SEARCH_SYS_VERSION $INSTALL_FILE
+    exit 0
+fi
+
+echo "Looking for config: $SEARCH_SYS"
+if [ -h "$SEARCH_SYS" ]; then
+    echo "Found suitable config"
+    cp -f $SEARCH_SYS $INSTALL_FILE
+    exit 0
+fi
+
+echo "Could not find a suitable config"
+rm -f $INSTALL_FILE
+
+exit 1

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
