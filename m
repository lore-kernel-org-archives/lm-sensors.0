From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 12 Sep 2013 11:08:15 +0000
Subject: Re: [lm-sensors] Backporting updated lm85 on RHEL5
Message-Id: <20130912130815.7780398d@endymion.delvare>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="MP_/U9TQodII+Ib+VoHoqzkHKkA"
List-Id: <lm-sensors.vger.kernel.org>
References: <5229DE5D.7060104@elrepo.org>
In-Reply-To: <5229DE5D.7060104@elrepo.org>
To: lm-sensors@vger.kernel.org

--MP_/U9TQodII+Ib+VoHoqzkHKkA
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi Phil,

On Thu, 12 Sep 2013 11:40:37 +0100, Phil Perry wrote:
> I'm doing this second-hand for another users. As noted above, I managed=20
> to backport most patches subsequent to the I2C change and the module=20
> compiles cleanly but still isn't working. The module loads but isn't=20
> producing any output.
>=20
> Below is the output the end user is seeing (he's also stuck on an old=20
> version of lm-sensors-2.10.8):
>=20
> [root@XXXX ~]# sensors-detect
> ...
> Now follows a summary of the probes I have just done.
> Just press ENTER to continue:
>=20
> Driver `lm85' (should be inserted):
>    Detects correctly:
>    * Bus `SMBus PIIX4 adapter at 0580'
>      Busdriver `i2c-piix4', I2C address 0x2e
>      Chip `SMSC EMC6D100, EMC6D101 or EMC6D102' (confidence: 7)
>=20
> Driver `k8temp' (should be inserted):
>    Detects correctly:
>    * Chip `AMD K8 thermal sensors' (confidence: 9)
>=20
> Do you want to overwrite /etc/sysconfig/lm_sensors? (YES/no):
> Starting lm_sensors: Error: Line 2429: Unknown feature name
> Error: Line 2430: Unknown feature name
> Error: Line 2431: Unknown feature name
> Error: Line 2432: Unknown feature name
> emc6d103-i2c-0-2e: No such feature known
>                                                             [ OK ]
>=20
> [root@srv ~]# sensors
> emc6d103-i2c-0-2e
> Adapter: SMBus PIIX4 adapter at 0580
>=20
> ....HERE SHOULD BE SOME OUTPUT BUT THERE IS NONE....
>=20
> k8temp-pci-00c3
> Adapter: PCI adapter
> Core0 Temp:
>               +54=C2=B0C
> Core1 Temp:
>               +46=C2=B0C
>=20
> k8temp-pci-00cb
> Adapter: PCI adapter
> Core0 Temp:
>               +48=C2=B0C
> Core1 Temp:
>               +50=C2=B0C
>=20
>=20
>=20
> Maybe we need to backport support for EMC6D103 into his old version of=20
> lm_sensors?

Yes, exactly. Contrary to version 3.x, lm_sensors 2.x needed per-chip
code on the user-space side. The EMC6D103 is too recent to have it.
Not only "sensors" but also libsensors had be told about every new chip
back then.

That being said the code should be almost the same as for other chips
supported by the lm85 so it should be easy enough to add. In fact I
think the EMC6D103 (not S) can be handled just the same as the
EMC6D102. The untested patch attached should do.

--=20
Jean Delvare

--MP_/U9TQodII+Ib+VoHoqzkHKkA
Content-Type: text/x-patch
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename=sensors-add-emc6d103-support.patch

---
 lib/chips.c          |    1 +
 lib/chips.h          |    1 +
 prog/sensors/chips.c |    6 ++++--
 prog/sensors/main.c  |    1 +
 4 files changed, 7 insertions(+), 2 deletions(-)

--- lm-sensors-2.10.orig/lib/chips.c	2010-11-03 13:13:04.000000000 +0100
+++ lm-sensors-2.10/lib/chips.c	2013-09-12 13:03:14.674954862 +0200
@@ -6469,6 +6469,7 @@ sensors_chip_features sensors_chip_featu
  { SENSORS_LM85C_PREFIX, lm85_features },
  { SENSORS_EMC6D100_PREFIX, lm85_features },
  { SENSORS_EMC6D102_PREFIX, lm85_features },
+ { SENSORS_EMC6D103_PREFIX, lm85_features },
  { SENSORS_ADM1027_PREFIX, adm1027_features },
  { SENSORS_ADT7463_PREFIX, adm1027_features },
  { SENSORS_LM83_PREFIX, lm83_features },
--- lm-sensors-2.10.orig/lib/chips.h	2008-10-20 10:03:50.000000000 +0200
+++ lm-sensors-2.10/lib/chips.h	2013-09-12 13:03:06.409954739 +0200
@@ -397,6 +397,7 @@
 #define SENSORS_ADT7463_PREFIX "adt7463"
 #define SENSORS_EMC6D100_PREFIX "emc6d100"
 #define SENSORS_EMC6D102_PREFIX "emc6d102"
+#define SENSORS_EMC6D103_PREFIX "emc6d103"
 
 #define SENSORS_ADM1027_ALARM_MASK           1  /* RW -- alarm_mask  */
 #define SENSORS_ADM1027_FAN1_PPR             2  /* RW -- fan1_ppr  */
--- lm-sensors-2.10.orig/prog/sensors/chips.c	2011-05-06 10:39:53.000000000 +0200
+++ lm-sensors-2.10/prog/sensors/chips.c	2013-09-12 13:06:09.181728002 +0200
@@ -1549,12 +1549,14 @@ void print_lm85(const sensors_chip_name
   char *label;
   double cur, min, max;
   int alarms, alarm_mask = 0, valid;
-  int is1027, is7463, is6d100, xadc;
+  int is1027, is7463, is6d100, is6d102, xadc;
 
   is7463 = !strcmp(name->prefix, "adt7463");
   is1027 = is7463 || !strcmp(name->prefix, "adm1027");
   is6d100 = !strcmp(name->prefix,"emc6d100") ;
-  xadc = is1027 || !strcmp(name->prefix, "emc6d102");
+  is6d102 = !strcmp(name->prefix, "emc6d102") ||
+            !strcmp(name->prefix, "emc6d103");
+  xadc = is1027 || is6d102;
 
   if (!sensors_get_feature(*name,SENSORS_LM85_ALARMS,&cur)) 
     alarms = cur + 0.5;
--- lm-sensors-2.10.orig/prog/sensors/main.c	2011-05-06 10:38:10.000000000 +0200
+++ lm-sensors-2.10/prog/sensors/main.c	2013-09-12 13:03:23.530954993 +0200
@@ -369,6 +369,7 @@ static struct match matches[] = {
 	{ "adt7463", print_lm85 },
 	{ "emc6d100", print_lm85 },
 	{ "emc6d102", print_lm85 },
+	{ "emc6d103", print_lm85 },
 	{ "lm87", print_lm87 },
 	{ "gl518sm", print_gl518 },
 	{ "gl520sm", print_gl520 },

--MP_/U9TQodII+Ib+VoHoqzkHKkA
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--MP_/U9TQodII+Ib+VoHoqzkHKkA--
