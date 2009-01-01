From: Hans de Goede <hdegoede@redhat.com>
Date: Thu, 01 Jan 2009 21:51:56 +0000
Subject: [lm-sensors] Patch: libsensors: add support for ACPI bus
Message-Id: <495D3AFC.5040809@redhat.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------070101030407000004040409"
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org

This is a multi-part message in MIME format.
--------------070101030407000004040409
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by mx2.redhat.com id
	n01LpDrr016464

Hi All,

The way the new atk0110 driver work it ends up being connected to an "ACP=
I"=20
bus, this patch adds support for this to lm_sensors-3.0.3

With this patch the sensors output on an Asus board looks like this:

atk0110-acpi-0
Adapter: ACPI interface
Vcore Voltage:          +1.45 V  (min =3D  +1.45 V, max =3D  +1.75 V)
  +3.3 Voltage:          +3.38 V  (min =3D  +3.00 V, max =3D  +3.60 V)
  +5.0 Voltage:          +5.16 V  (min =3D  +4.50 V, max =3D  +5.50 V)
+12.0 Voltage:         +12.24 V  (min =3D +11.20 V, max =3D +13.20 V)
CPU FAN Speed:         1516 RPM  (min =3D    0 RPM)
CHASSIS FAN Speed:        0 RPM  (min =3D    0 RPM)
POWER FAN Speed:          0 RPM  (min =3D    0 RPM)
CHASSIS4 FAN FAN Speed:   0 RPM  (min =3D    0 RPM)
CHASSIS2 FAN FAN Speed:   0 RPM  (min =3D    0 RPM)
CHASSIS3 FAN FAN Speed:   0 RPM  (min =3D    0 RPM)
CPU Temperature:        +43.0=B0C  (high =3D +90.0=B0C, crit =3D +125.0=B0=
C)
MB Temperature:         +44.0=B0C  (high =3D +45.0=B0C, crit =3D +90.0=B0=
C)


Jean, can you please review this patch, if its ok I can apply it myself.

Thanks & Regards,

Hans


p.s.

Also see my related (to be written) ACPI versus native IC drivers post

--------------070101030407000004040409
Content-Type: text/plain;
 name="lm_sensors-3.0.3-acpi-bus.patch"
Content-Disposition: inline;
 filename="lm_sensors-3.0.3-acpi-bus.patch"
Content-Transfer-Encoding: 7bit

Index: lib/access.c
===================================================================
--- lib/access.c	(revision 5577)
+++ lib/access.c	(working copy)
@@ -349,6 +349,8 @@
 		return "SPI adapter";
 	case SENSORS_BUS_TYPE_VIRTUAL:
 		return "Virtual device";
+	case SENSORS_BUS_TYPE_ACPI:
+		return "ACPI interface";
 	}
 
 	/* bus types with several instances */
Index: lib/sensors.h
===================================================================
--- lib/sensors.h	(revision 5577)
+++ lib/sensors.h	(working copy)
@@ -42,6 +42,7 @@
 #define SENSORS_BUS_TYPE_PCI		2
 #define SENSORS_BUS_TYPE_SPI		3
 #define SENSORS_BUS_TYPE_VIRTUAL	4
+#define SENSORS_BUS_TYPE_ACPI		5
 #define SENSORS_BUS_NR_ANY		(-1)
 #define SENSORS_BUS_NR_IGNORE		(-2)
 
Index: lib/sysfs.c
===================================================================
--- lib/sysfs.c	(revision 5577)
+++ lib/sysfs.c	(working copy)
@@ -596,6 +596,11 @@
 			entry.chip.addr = 0;
 		entry.chip.bus.type = SENSORS_BUS_TYPE_ISA;
 		entry.chip.bus.nr = 0;
+	} else if (subsys && !strcmp(subsys, "acpi")) {
+		entry.chip.bus.type = SENSORS_BUS_TYPE_ACPI;
+		/* For now we assume that acpi devices are unique */
+		entry.chip.bus.nr = 0;
+		entry.chip.addr = 0;
 	} else {
 		/* Ignore unknown device */
 		err = 0;
Index: lib/data.c
===================================================================
--- lib/data.c	(revision 5577)
+++ lib/data.c	(working copy)
@@ -111,6 +111,8 @@
 		res->bus.type = SENSORS_BUS_TYPE_SPI;
 	else if (!strncmp(name, "virtual", dash - name))
 		res->bus.type = SENSORS_BUS_TYPE_VIRTUAL;
+	else if (!strncmp(name, "acpi", dash - name))
+		res->bus.type = SENSORS_BUS_TYPE_ACPI;
 	else
 		goto ERROR;
 	name = dash + 1;
@@ -174,6 +176,9 @@
 	case SENSORS_BUS_TYPE_VIRTUAL:
 		return snprintf(str, size, "%s-virtual-%x", chip->prefix,
 				chip->addr);
+	case SENSORS_BUS_TYPE_ACPI:
+		return snprintf(str, size, "%s-acpi-%x", chip->prefix,
+				chip->addr);
 	}
 
 	return -SENSORS_ERR_CHIP_NAME;

--------------070101030407000004040409
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--------------070101030407000004040409--
