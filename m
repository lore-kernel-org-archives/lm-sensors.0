From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 18 Sep 2007 19:26:14 +0000
Subject: Re: [lm-sensors] "sensord --rrd-file" cant't find a sensor
Message-Id: <20070918212614.5e39757c@hyperion.delvare>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="MP_KN08n1wsZVmn8RqpnTeIDHy"
List-Id: <lm-sensors.vger.kernel.org>
References: <46DE9261.8030900@sthias.de>
In-Reply-To: <46DE9261.8030900@sthias.de>
To: lm-sensors@vger.kernel.org

--MP_KN08n1wsZVmn8RqpnTeIDHy
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi again Sebastian,

On Tue, 18 Sep 2007 20:56:17 +0200, Jean Delvare wrote:
> On Wed, 05 Sep 2007 13:26:25 +0200, Sebastian Thias wrote:
> > Any idea what could be wrong...?
> 
> sensord simply lacks support for the w83793 driver, which is rather
> recent.

Here's a patch adding support for the w83793 driver to sensord. It's
untested as I do not have the hardware. You can give it a try and
report.

Known limitations:
* Alarms are not supported.
* You may have to add ignore statements in sensors.conf for missing
  features.

-- 
Jean Delvare
http://khali.linux-fr.org/wishlist.html

--MP_KN08n1wsZVmn8RqpnTeIDHy
Content-Type: text/x-patch; name=sensord-w83793.patch
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment; filename=sensord-w83793.patch

Index: prog/sensord/chips.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- prog/sensord/chips.c	(r=C3=A9vision 4797)
+++ prog/sensord/chips.c	(copie de travail)
@@ -1285,7 +1285,83 @@
   k8temp_names, k8temp_features, 0, 0
 };
=20
+/** W83793 **/
=20
+static const char *w83793_names[] =3D {
+  SENSORS_W83793_PREFIX, NULL
+};
+
+static const FeatureDescriptor w83793_features[] =3D {
+  { fmtFans_0, rrdF0, DataType_rpm, 0, 0,
+    { SENSORS_W83793_FAN(1), SENSORS_W83793_FAN_MIN(1), -1 } },
+  { fmtFans_0, rrdF0, DataType_rpm, 0, 0,
+    { SENSORS_W83793_FAN(2), SENSORS_W83793_FAN_MIN(2), -1 } },
+  { fmtFans_0, rrdF0, DataType_rpm, 0, 0,
+    { SENSORS_W83793_FAN(3), SENSORS_W83793_FAN_MIN(3), -1 } },
+  { fmtFans_0, rrdF0, DataType_rpm, 0, 0,
+    { SENSORS_W83793_FAN(4), SENSORS_W83793_FAN_MIN(4), -1 } },
+  { fmtFans_0, rrdF0, DataType_rpm, 0, 0,
+    { SENSORS_W83793_FAN(5), SENSORS_W83793_FAN_MIN(5), -1 } },
+  { fmtFans_0, rrdF0, DataType_rpm, 0, 0,
+    { SENSORS_W83793_FAN(6), SENSORS_W83793_FAN_MIN(6), -1 } },
+  { fmtFans_0, rrdF0, DataType_rpm, 0, 0,
+    { SENSORS_W83793_FAN(7), SENSORS_W83793_FAN_MIN(7), -1 } },
+  { fmtFans_0, rrdF0, DataType_rpm, 0, 0,
+    { SENSORS_W83793_FAN(8), SENSORS_W83793_FAN_MIN(8), -1 } },
+  { fmtFans_0, rrdF0, DataType_rpm, 0, 0,
+    { SENSORS_W83793_FAN(9), SENSORS_W83793_FAN_MIN(9), -1 } },
+  { fmtFans_0, rrdF0, DataType_rpm, 0, 0,
+    { SENSORS_W83793_FAN(10), SENSORS_W83793_FAN_MIN(10), -1 } },
+  { fmtFans_0, rrdF0, DataType_rpm, 0, 0,
+    { SENSORS_W83793_FAN(11), SENSORS_W83793_FAN_MIN(11), -1 } },
+  { fmtFans_0, rrdF0, DataType_rpm, 0, 0,
+    { SENSORS_W83793_FAN(12), SENSORS_W83793_FAN_MIN(12), -1 } },
+  { fmtTemps_1, rrdF1, DataType_temperature, 0, 0,
+    { SENSORS_W83793_TEMP(1), SENSORS_W83793_TEMP_CRIT(1), SENSORS_W83793_=
TEMP_CRIT_HYST(1), -1 } },
+  { fmtTemps_1, rrdF1, DataType_temperature, 0, 0,
+    { SENSORS_W83793_TEMP(2), SENSORS_W83793_TEMP_CRIT(2), SENSORS_W83793_=
TEMP_CRIT_HYST(2), -1 } },
+  { fmtTemps_1, rrdF1, DataType_temperature, 0, 0,
+    { SENSORS_W83793_TEMP(3), SENSORS_W83793_TEMP_CRIT(3), SENSORS_W83793_=
TEMP_CRIT_HYST(3), -1 } },
+  { fmtTemps_1, rrdF1, DataType_temperature, 0, 0,
+    { SENSORS_W83793_TEMP(4), SENSORS_W83793_TEMP_CRIT(4), SENSORS_W83793_=
TEMP_CRIT_HYST(4), -1 } },
+  { fmtTemps_0, rrdF0, DataType_temperature, 0, 0,
+    { SENSORS_W83793_TEMP(5), SENSORS_W83793_TEMP_CRIT(5), SENSORS_W83793_=
TEMP_CRIT_HYST(5), -1 } },
+  { fmtTemps_0, rrdF0, DataType_temperature, 0, 0,
+    { SENSORS_W83793_TEMP(6), SENSORS_W83793_TEMP_CRIT(6), SENSORS_W83793_=
TEMP_CRIT_HYST(6), -1 } },
+  { fmtVolts_2, rrdF2, DataType_voltage, 0, 0,
+    { SENSORS_W83793_IN(0), SENSORS_W83793_IN_MIN(0), SENSORS_W83793_IN_MA=
X(0), -1 } },
+  { fmtVolts_2, rrdF2, DataType_voltage, 0, 0,
+    { SENSORS_W83793_IN(1), SENSORS_W83793_IN_MIN(1), SENSORS_W83793_IN_MA=
X(1), -1 } },
+  { fmtVolts_2, rrdF2, DataType_voltage, 0, 0,
+    { SENSORS_W83793_IN(2), SENSORS_W83793_IN_MIN(2), SENSORS_W83793_IN_MA=
X(2), -1 } },
+  { fmtVolts_2, rrdF2, DataType_voltage, 0, 0,
+    { SENSORS_W83793_IN(3), SENSORS_W83793_IN_MIN(3), SENSORS_W83793_IN_MA=
X(3), -1 } },
+  { fmtVolts_2, rrdF2, DataType_voltage, 0, 0,
+    { SENSORS_W83793_IN(4), SENSORS_W83793_IN_MIN(4), SENSORS_W83793_IN_MA=
X(4), -1 } },
+  { fmtVolts_2, rrdF2, DataType_voltage, 0, 0,
+    { SENSORS_W83793_IN(5), SENSORS_W83793_IN_MIN(5), SENSORS_W83793_IN_MA=
X(5), -1 } },
+  { fmtVolts_2, rrdF2, DataType_voltage, 0, 0,
+    { SENSORS_W83793_IN(6), SENSORS_W83793_IN_MIN(6), SENSORS_W83793_IN_MA=
X(6), -1 } },
+  { fmtVolts_2, rrdF2, DataType_voltage, 0, 0,
+    { SENSORS_W83793_IN(7), SENSORS_W83793_IN_MIN(7), SENSORS_W83793_IN_MA=
X(7), -1 } },
+  { fmtVolts_2, rrdF2, DataType_voltage, 0, 0,
+    { SENSORS_W83793_IN(8), SENSORS_W83793_IN_MIN(8), SENSORS_W83793_IN_MA=
X(8), -1 } },
+  { fmtVolts_2, rrdF2, DataType_voltage, 0, 0,
+    { SENSORS_W83793_IN(9), SENSORS_W83793_IN_MIN(9), SENSORS_W83793_IN_MA=
X(9), -1 } },
+  { fmtVolts_2, rrdF2, DataType_voltage, 0, 0,
+    { SENSORS_W83793_IN(10), SENSORS_W83793_IN_MIN(10), SENSORS_W83793_IN_=
MAX(10), -1 } },
+  { fmtVolt_3, rrdF3, DataType_voltage, 0, 0,
+    { SENSORS_W83793_VID0, -1 } },
+  { fmtVolt_3, rrdF3, DataType_voltage, 0, 0,
+    { SENSORS_W83793_VID1, -1 } },
+  { NULL }
+};
+
+static const ChipDescriptor w83793_chip =3D {
+  w83793_names, w83793_features, 0, 0
+};
+
+
 /** ALL **/
=20
 const ChipDescriptor * const knownChips[] =3D {
@@ -1314,5 +1390,6 @@
   &f71805f_chip,
   &vt1211_chip,
   &k8temp_chip,
+  &w83793_chip,
   NULL
 };

--MP_KN08n1wsZVmn8RqpnTeIDHy
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--MP_KN08n1wsZVmn8RqpnTeIDHy--
