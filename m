From: Andre Prendel <andre.prendel@gmx.de>
Date: Wed, 14 Apr 2010 18:28:58 +0000
Subject: [lm-sensors] [PATCH v4 2/2] Add sensors config install script
Message-Id: <20100414182858.GC1985@andre-laptop>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

This shell script searches for suitable configuration files due to
systems DMI data, installs them and loads necessary driver(s)

Index: sensors/prog/detect/install.sh
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ sensors/prog/detect/install.sh	2010-04-13 20:59:26.931071291 +0200
@@ -0,0 +1,59 @@
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
+load_drivers()
+{
+    while read a b c; do
+	if [ "$a" =3D "#" ]; then
+	    if [ "$b" =3D "module:" ]; then
+		driver=3D`echo $c | tr -d '\r'`
+		echo "Loading driver: $driver"
+		modprobe $driver
+	    fi
+	fi
+    done < $INSTALL_FILE
+}
+
+search_config()
+{
+    echo "Looking for config: $1"
+    if [ -h "$1" ]; then
+	echo "Found suitable config"
+	cp -f $1 $INSTALL_FILE
+	load_drivers
+	exit 0
+    fi
+}
+
+for search in "$SEARCH_BOARD_VERSION" "$SEARCH_BOARD" "$SEARCH_SYS_VERSION=
" "$SEARCH_SYS"
+do
+    search_config "$search"
+done
+
+echo "Could not find a suitable config"
+rm -f $INSTALL_FILE
+
+exit 1

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
