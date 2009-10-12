From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 12 Oct 2009 12:12:13 +0000
Subject: Re: [lm-sensors] How do you make lm_sensors see a hwmon device?
Message-Id: <20091012141213.223d8102@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <4AD1E14B.90604@shikadi.net>
In-Reply-To: <4AD1E14B.90604@shikadi.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi Adam,

On Mon, 12 Oct 2009 08:32:02 +1000, Adam Nielsen wrote:
> Although the underlying device is USB, the device appears in the relative=
ly
> new "hid" class, as it is a standard USB HID device (I imagine so it does=
n't
> require kernel drivers to be installed under Windows.)
>=20
> > Oh, please also send the output of:=20
> > $ ls -l /sys/class/hwmon/hwmon*/device
>=20
> lrwxrwxrwx 1 root root 0 2009-10-11 22:55 /sys/class/hwmon/hwmon0/device =
->
> ../../../devices/platform/it87.656
> lrwxrwxrwx 1 root root 0 2009-10-11 21:28 /sys/class/hwmon/hwmon1/device =
->
> ../../../devices/platform/coretemp.0
> lrwxrwxrwx 1 root root 0 2009-10-11 21:28 /sys/class/hwmon/hwmon2/device =
->
> ../../../devices/platform/coretemp.1
> lrwxrwxrwx 1 root root 0 2009-10-11 21:28 /sys/class/hwmon/hwmon3/device =
->
> ../../../devices/platform/coretemp.2
> lrwxrwxrwx 1 root root 0 2009-10-11 21:28 /sys/class/hwmon/hwmon4/device =
->
> ../../../devices/platform/coretemp.3
> lrwxrwxrwx 1 root root 0 2009-10-11 23:40 /sys/class/hwmon/hwmon5/device =
->
> ../../../devices/pci0000:00/0000:00:1d.2/usb8/8-1/8-1:1.0/0003:1044:4001.=
0012

Ouch. This bus ID format is pretty nasty. It includes vendor and
product IDs, which really do not belong there. And the last part is an
auto-incremented counter, so it isn't stable.

I've done what I could to make it fit in what libsensors expects, but
this is less than perfect. And I expect this bus ID format to evolve
over time, because I can't be the only one thinking it sucks. So we may
have to update libsensors for future kernels.

For now, can you please send me the output of:
$ ls -l /sys/bus/hid/devices

> > And I am curious about your USB device and what sensors it has. If
> > these are I2C sensor chips and there's an I2C bus inside the device, it
> > may make more sense to write a bus drivers for that I2C segment, and
> > use regular I2C sensor chip drivers on top of it. But of course it
> > depends whether you have all the needed technical information to do
> > this or not (if the hardware design allows it at all.)
>=20
> I am unsure what type of chips are inside the device, but whatever they a=
re
> the HID protocol abstracts it away so you never get direct access.
> Essentially you send a number to the device and it responds with a few by=
tes,
> to which you apply a formula and obtain the sensor reading.

OK, let's handle it as a HID device then. Experimental libsensors patch
at the end of this message, please give it a try and report. I couldn't
test it so there might be some rough edges left.

This power supply unit you're working on seems pretty cool. Is this
something one can buy for his/her PC, or only meant for high end server
racks or something? Care to tell us the brand and model name? I would
love to have a monitorable PSU.

> If it would help I can post a gadgetfs userspace program I wrote to emula=
te
> the device.  When you run this - assuming you have gadgetfs support in yo=
ur
> kernel set up with the "dummy" device - you will see a new USB device app=
ear
> on your system which behaves the same as the real device.  You can then l=
oad
> my driver and it will talk to the "fake" device.  (Just as a bit of backg=
round
> this proved extremely useful for reverse engineering the device - I was a=
ble
> to tell my fake device what data to respond with, and using VirtualBox, s=
ee
> which sensors changed in the manufacturer's Windows program as the fake d=
evice
> responded with different values.)

Yes, please post it together with explanations how to use it. If I can
emulate the device and test my libsensors patches myself, this should
be much faster.

Here's the patch:

Index: lib/sensors.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D--- lib/sensors.h	(r=E9vision 5780)
+++ lib/sensors.h	(copie de travail)
@@ -43,6 +43,7 @@
 #define SENSORS_BUS_TYPE_SPI		3
 #define SENSORS_BUS_TYPE_VIRTUAL	4
 #define SENSORS_BUS_TYPE_ACPI		5
+#define SENSORS_BUS_TYPE_HID		6
 #define SENSORS_BUS_NR_ANY		(-1)
 #define SENSORS_BUS_NR_IGNORE		(-2)
=20
Index: lib/access.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D--- lib/access.c	(r=E9vision 5780)
+++ lib/access.c	(copie de travail)
@@ -363,6 +363,10 @@
 		return "Virtual device";
 	case SENSORS_BUS_TYPE_ACPI:
 		return "ACPI interface";
+	/* HID should probably not be there either, but I don't know if
+	   HID buses have a name nor where to find it. */
+	case SENSORS_BUS_TYPE_HID:
+		return "HID adapter";
 	}
=20
 	/* bus types with several instances */
Index: lib/sysfs.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D--- lib/sysfs.c	(r=E9vision 5780)
+++ lib/sysfs.c	(copie de travail)
@@ -518,7 +518,7 @@
 				       const char *dev_name,
 				       const char *hwmon_path)
 {
-	int domain, bus, slot, fn;
+	int domain, bus, slot, fn, vendor, product, id;
 	int err =3D -SENSORS_ERR_KERNEL;
 	char *bus_attr;
 	char bus_path[NAME_MAX];
@@ -612,6 +612,13 @@
 		/* For now we assume that acpi devices are unique */
 		entry.chip.bus.nr =3D 0;
 		entry.chip.addr =3D 0;
+	} else
+	if (subsys && !strcmp(subsys, "hid") &&
+	    sscanf(dev_name, "%x:%x:%x.%x", &bus, &vendor, &product, &id) =3D 4) {
+		entry.chip.bus.type =3D SENSORS_BUS_TYPE_HID;
+		/* As of kernel 2.6.32, the hid device names don't look good */
+		entry.chip.bus.nr =3D bus;
+		entry.chip.addr =3D id;
 	} else {
 		/* Ignore unknown device */
 		err =3D 0;
Index: lib/data.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D--- lib/data.c	(r=E9vision 5780)
+++ lib/data.c	(copie de travail)
@@ -121,6 +121,8 @@
 		res->bus.type =3D SENSORS_BUS_TYPE_VIRTUAL;
 	else if (!strncmp(name, "acpi", dash - name))
 		res->bus.type =3D SENSORS_BUS_TYPE_ACPI;
+	else if (!strncmp(name, "hid", dash - name))
+		res->bus.type =3D SENSORS_BUS_TYPE_HID;
 	else
 		goto ERROR;
 	name =3D dash + 1;
@@ -131,6 +133,7 @@
 	switch (res->bus.type) {
 	case SENSORS_BUS_TYPE_I2C:
 	case SENSORS_BUS_TYPE_SPI:
+	case SENSORS_BUS_TYPE_HID:
 		if (!strncmp(name, "*-", 2)) {
 			res->bus.nr =3D SENSORS_BUS_NR_ANY;
 			name +=3D 2;
@@ -187,6 +190,9 @@
 	case SENSORS_BUS_TYPE_ACPI:
 		return snprintf(str, size, "%s-acpi-%x", chip->prefix,
 				chip->addr);
+	case SENSORS_BUS_TYPE_HID:
+		return snprintf(str, size, "%s-hid-%hd-%x", chip->prefix,
+				chip->bus.nr, chip->addr);
 	}
=20
 	return -SENSORS_ERR_CHIP_NAME;


--=20
Jean Delvare
http://khali.linux-fr.org/wishlist.html

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
