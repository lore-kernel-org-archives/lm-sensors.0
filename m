From: Luca Tettamanti <kronos.it@gmail.com>
Date: Mon, 30 Jun 2008 19:58:45 +0000
Subject: Re: [lm-sensors] Asus atk0110 driver
Message-Id: <20080630195845.GA10339@dreamland.darkstar.lan>
List-Id: <lm-sensors.vger.kernel.org>
References: <20080618212629.GA7917@dreamland.darkstar.lan>
In-Reply-To: <20080618212629.GA7917@dreamland.darkstar.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Il Mon, Jun 23, 2008 at 11:06:01AM +0200, Jean Delvare ha scritto:=20
> Hi Gabriel,
>=20
> On Sun, 22 Jun 2008 18:15:51 +0200, Gabriel C wrote:
> > I've tested the driver with linux-next on my P5E-VM DO motherboard.
> >=20
> > The driver seems to work , the values / data in  /sys/class/hwmon/hwmon=
0/device/*
> > seems to be the same like what the BIOS reports.
> >=20
> > However how do I get sensors to display the data from atk driver ?
> > I guess I have to patch lm-sensors ?
>=20
> For lm-sensors 2.10.x, yes, you'd need to patch libsensors and sensors
> and virtually every monitoring application out there.
>=20
> But the preferred solution is to just upgrade to lm-sensors 3.0.x,
> which automatically detects the device features, so every new driver is
> supported right away.

Not really, the hwmon device is linked directly to the ACPI node in the
sysfs hierarchy (via subsystem link): lm-sensors just ignores it.

Patch is simple enough though:

---
 Makefile      |    6 +++---
 lib/access.c  |    2 ++
 lib/data.c    |    5 +++++
 lib/sensors.h |    1 +
 lib/sysfs.c   |    5 +++++
 5 files changed, 16 insertions(+), 3 deletions(-)

Index: lib/access.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D--- lib/access.c	(revision 5296)
+++ lib/access.c	(working copy)
@@ -349,6 +349,8 @@
 		return "SPI adapter";
 	case SENSORS_BUS_TYPE_VIRTUAL:
 		return "Virtual device";
+	case SENSORS_BUS_TYPE_ACPI:
+		return "ACPI device";
 	}
=20
 	/* bus types with several instances */
Index: lib/sensors.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D--- lib/sensors.h	(revision 5296)
+++ lib/sensors.h	(working copy)
@@ -42,6 +42,7 @@
 #define SENSORS_BUS_TYPE_PCI		2
 #define SENSORS_BUS_TYPE_SPI		3
 #define SENSORS_BUS_TYPE_VIRTUAL	4
+#define SENSORS_BUS_TYPE_ACPI		5
 #define SENSORS_BUS_NR_ANY		(-1)
 #define SENSORS_BUS_NR_IGNORE		(-2)
=20
Index: lib/sysfs.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D--- lib/sysfs.c	(revision 5296)
+++ lib/sysfs.c	(working copy)
@@ -579,6 +579,11 @@
 			entry.chip.addr =3D 0;
 		entry.chip.bus.type =3D SENSORS_BUS_TYPE_ISA;
 		entry.chip.bus.nr =3D 0;
+	} else
+	if ((!subsys || !strcmp(subsys, "acpi")) &&
+	    sscanf(dev_name, "%*[a-zA-Z0-9_]:%d", &entry.chip.addr) =3D 1) {
+		entry.chip.bus.type =3D SENSORS_BUS_TYPE_ACPI;
+		entry.chip.bus.nr =3D 0;
 	} else {
 		/* Ignore unknown device */
 		err =3D 0;
Index: lib/data.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D--- lib/data.c	(revision 5296)
+++ lib/data.c	(working copy)
@@ -111,6 +111,8 @@
 		res->bus.type =3D SENSORS_BUS_TYPE_SPI;
 	else if (!strncmp(name, "virtual", dash - name))
 		res->bus.type =3D SENSORS_BUS_TYPE_VIRTUAL;
+	else if (!strncmp(name, "acpi", dash - name))
+		res->bus.type =3D SENSORS_BUS_TYPE_ACPI;
 	else
 		goto ERROR;
 	name =3D dash + 1;
@@ -174,6 +176,9 @@
 	case SENSORS_BUS_TYPE_VIRTUAL:
 		return snprintf(str, size, "%s-virtual-%x", chip->prefix,
 				chip->addr);
+	case SENSORS_BUS_TYPE_ACPI:
+		return snprintf(str, size, "%s-acpi-%x", chip->prefix,
+				chip->addr);
 	}
=20
 	return -SENSORS_ERR_CHIP_NAME;

With the patch applied sensors is able to display all the data:

atk0110-acpi-0
Adapter: ACPI device
Vcore Voltage:      +1.12 V  (min =3D  +0.85 V, max =3D  +1.60 V)
 +3.3 Voltage:      +3.31 V  (min =3D  +2.97 V, max =3D  +3.63 V)
 +5 Voltage:        +5.12 V  (min =3D  +4.50 V, max =3D  +5.50 V)
 +12 Voltage:      +12.41 V  (min =3D +10.20 V, max =3D +13.80 V)
CPU FAN Speed:     2860 RPM  (min =3D  600 RPM)
CHASSIS1 FAN Speed:   0 RPM  (min =3D  800 RPM)
CHASSIS2 FAN Speed:   0 RPM  (min =3D  800 RPM)
POWER FAN Speed:      0 RPM  (min =3D  800 RPM)
CPU Temperature:    +48.5=B0C  (high =3D +60.0=B0C, crit =3D +95.0=B0C)
MB Temperature:     +42.0=B0C  (high =3D +45.0=B0C, crit =3D +95.0=B0C)

> > Luca what do you think about creating  a proper patch for the driver to=
o and send it over to=20
> > Greg to be included in his linux-staging tree ? I think that way it wil=
l get more testing.

Will do ;)

Luca
--=20
Sono un mirabile incrocio tra Tarzan e Giacomo Leopardi.
In me convivono tutte le doti intelluttuali di Tarzan e
tutta la prestanza fisica di Giacomo Leopardi.
A. Borsani

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
