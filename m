From: ppokorny@penguincomputing.com (Philip Pokorny)
Date: Thu, 19 May 2005 06:25:25 +0000
Subject: [PATCH] prog/init/lm_sensors.init: reduce verbosity, MAKEDEV,
Message-Id: <41B52E5A.9030007@penguincomputing.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20041207014837.GC23447@neu.nirvana>
In-Reply-To: <20041207014837.GC23447@neu.nirvana>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

This patch has me thinking...

What do people think about changing the format of the=20
sysconfig/lm_sensors config file from

MODULE_0=3Di2c-i801
MODULE_1=3Di2c-isa
MODULE_2=3Dlm85
MODULE_3=EEprom
MODULE_4=3Dw83781d

to

BUSES=3D"i2c-i801 i2c-isa"
MODULES=3D"lm85 eeprom w83781d"

If we did this, then we could get rid of the confusing and obscure=20
backticks and eval in the module loading loop, replacing it with=20
something simple like:

   for module in $MODULES ; do
      echo -n __$module__
      modprobe $module
   done

Which seems much clearer to me.

This would also mean that users would no longer have to edit variable=20
names to keep them sequential when adding, removing or re-ordering modules.

If I hear agreement, I'll work up a patch.  We'll need to modify=20
sensors-detect to generate the new format.

:v)


Axel Thimm wrote:

>Hi,
>
>the attached patch is partly including some patching by Red Hat, which
>are distribution independent.
>
>It exits early on absence of config files, or empty config files (no
>MODULE_* entries) to avoid noise at startup of lm_sensors unconfigured
>systems.
>
>There is also a MAKEDEV in the start command. This may be required for
>proper udev operation.
>
>It also fixes a couple of minor other things like to output of the
>usage ($0 instead of fixed "sensors.init" etc).
> =20
>
>------------------------------------------------------------------------
>
>Index: prog/init/lm_sensors.init
>=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D>RCS file: /home/cvs/lm_sensors2/prog/init/lm_se=
nsors.init,v
>retrieving revision 1.6
>diff -u -d -r1.6 lm_sensors.init
>--- prog/init/lm_sensors.init	27 Nov 2004 04:24:41 -0000	1.6
>+++ prog/init/lm_sensors.init	7 Dec 2004 01:47:20 -0000
>@@ -47,6 +47,12 @@
> fi
>=20
> CONFIG=3D/etc/sysconfig/lm_sensors
>+[ -r "$CONFIG" ] || exit 0
>+egrep '^MODULE_' $CONFIG &>/dev/null || exit 0
>+
>+# Load config file
>+. "$CONFIG"
>+
> PSENSORS=3D/usr/local/bin/sensors
>=20
> if [ ! -x $PSENSORS ]; then
>@@ -57,16 +63,17 @@
> . /etc/init.d/functions
>=20
> RETVAL=3D0
>+prog=3D"lm_sensors"
>=20
> start() {
>-	echo -n $"Starting up sensors: "
>-	test -r "$CONFIG" && . "$CONFIG"
>+	echo -n $"Starting $prog: starting module "
>=20
>+	/sbin/MAKEDEV i2c
> 	modules=3D`grep \^MODULE_ $CONFIG | wc -l | tr -d ' '`
> 	i=3D0
> 	while [ $i -lt $modules ] ; do
> 		module=3D`eval echo '$'MODULE_$i`
>-		echo starting module __${module}__
>+		echo -n "__${module}__ "
> 		/sbin/modprobe $module &>/dev/null
> 		i=3D`expr $i + 1`
> 	done
>@@ -83,8 +90,7 @@
> }
>=20
> stop() {
>-	echo -n $"Shutting down sensors: "
>-	test -r "$CONFIG" && . "$CONFIG"
>+	echo -n $"Stopping $prog: "
>=20
> 	modules=3D`grep \^MODULE_ $CONFIG | wc -l | tr -d ' '`
> 	i=3D`expr $modules`
>@@ -141,7 +147,7 @@
> 	condrestart
> 	;;
>   *)
>-	echo "Usage: sensors.init {start|stop|status|restart|reload|condrestart}"
>+	echo $"Usage: $0 {start|stop|status|restart|reload|condrestart}"
> 	exit 1
> esac
>=20
> =20
>

--=20
Philip Pokorny, Director of Engineering
Tel: 415-954-2823   Fax: 415-954-2899   Toll Free: 888-PENGUIN
PENGUIN COMPUTING, INC.
www.penguincomputing.com
