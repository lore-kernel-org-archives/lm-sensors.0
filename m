From: Andre Prendel <andre.prendel@gmx.de>
Date: Sat, 10 Apr 2010 21:49:16 +0000
Subject: Re: [lm-sensors] [RFC PATCH v3 0/2] Add sensors config tool
Message-Id: <20100410214916.GA12066@andre-laptop>
List-Id: <lm-sensors.vger.kernel.org>
References: <20100331200353.GA2002@andre-laptop>
In-Reply-To: <20100331200353.GA2002@andre-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

On Thu, Apr 01, 2010 at 08:56:31AM +0200, Hans de Goede wrote:
> Hi Andre,
>=20
> On 03/31/2010 10:03 PM, Andre Prendel wrote:
> >Hi Hans,
> >
> >At last here is a new version of the sensors config tool.
> >
> >
> >Next task is the module auto loading stuff but first, what about this
> >here?
> >
>=20
> I think this all looks very good! I think the module auto loading
> is the only remaining item to do before this could actually become
> production ready (although we will want Jean's input on this too).
>=20
> The module autoloading requires 2 questions to be answered:
>=20
> 1) How do we store which modules are needed into the configuration
>    files on the wiki
>=20
> 2) How / where / what will these modules get loaded ? Currently we
>    have lines like these in /etc/sysconfig/lm_sensors:
>=20
> # The format of this file is a shell script that simply defines variables:
> # HWMON_MODULES for hardware monitoring driver modules, and optionally
> # BUS_MODULES for any required bus driver module (for example for I2C or =
SPI).
>=20
> HWMON_MODULES=3D"it87"
>=20
> # For compatibility reasons, modules are also listed individually as vari=
ables
> #    MODULE_0, MODULE_1, MODULE_2, etc.
> # You should use BUS_MODULES and HWMON_MODULES instead if possible.
>=20
> MODULE_0=3Dit87
>=20
>=20
> We could add new "keys" to this file, say:
> AUTOMOBO_HWMON_MODULES
> AUTOMOBO_BUS_MODULES
>=20
> And modify the lm_sensors initscript to recognize these too, or thinking =
more
> about this, as we need the script which does the copying of the config fi=
le
> to /etc/sensors.d/automobo.conf, to extract the modules for us anyways (to
> insert them into /etc/sysconfig/lm_sensors for example). We might just as
> well make that script load the modules directly.
>=20
> This also solves a problem with the HWMON_MODULES=3D"it87" syntax, namely
> that it does not allow specifying module parameters.
>=20
> Jean, could we have your input on this ?

No reply from Jean so far. So I'd like to make a proposal.

I'd suggest using the install.sh script (which installs the
automobo.conf) to load the driver. The config file gets a "modules" tag
specifying the module name. E.g.

  # board_name: foo
  # board_vendor: bar

  # modules: tmp421

Sed gives us the module name and modprobe loads the module. I've
extended the install.sh script to do this. See the patch below
(load_driver function).

What do you think about this approach?

Thanks,
Andre

---
Index: sensors/prog/detect/install.sh
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ sensors/prog/detect/install.sh	2010-04-10 23:37:38.510513143 +0200
@@ -0,0 +1,69 @@
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
+load_driver()
+{
+    MODULES=3D`sed -n -e 's/^# modules: \([A-Za-z0-9=3D ]*\).*$/\1/p' $INS=
TALL_FILE`
+    echo "Loading driver: $MODULES"
+    modprobe $MODULES
+}
+
+echo "Looking for config: $SEARCH_BOARD_VERSION"
+if [ -h "$SEARCH_BOARD_VERSION" ]; then
+    echo "Found suitable config"
+    cp -f $SEARCH_BOARD_VERSION $INSTALL_FILE
+    load_driver
+    exit 0
+fi
+
+echo "Looking for config: $SEARCH_BOARD"
+if [ -h "$SEARCH_BOARD" ]; then
+    echo "Found suitable config"
+    cp -f $SEARCH_BOARD $INSTALL_FILE
+    load_driver
+    exit 0
+fi
+
+echo "Looking for config: $SEARCH_SYS_VERSION"
+if [ -h "$SEARCH_SYS_VERSION" ]; then
+    echo "Found suitable config"
+    cp -f $SEARCH_SYS_VERSION $INSTALL_FILE
+    load_driver
+    exit 0
+fi
+
+echo "Looking for config: $SEARCH_SYS"
+if [ -h "$SEARCH_SYS" ]; then
+    echo "Found suitable config"
+    cp -f $SEARCH_SYS $INSTALL_FILE
+    load_driver
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
