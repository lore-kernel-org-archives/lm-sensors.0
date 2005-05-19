From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:58 +0000
Subject: ADM1030/ADM1031 user-space support
Message-Id: <20040517215728.09bfee29.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040517100022.54fae886.khali@linux-fr.org>
In-Reply-To: <20040517100022.54fae886.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> Here is attached an updated version of the user-space support for the
> adm1030 type of chips according to Jean's comments.

diff -urN -x CVS lm_sensors2/etc/sensors.conf.eg lm_sensors2_mine/etc/sensors.conf.eg
--- lm_sensors2/etc/sensors.conf.eg	2004-05-11 20:58:39.000000000 +0200
+++ lm_sensors2_mine/etc/sensors.conf.eg	2004-05-17 14:55:38.000000000 +0200
@@ -2113,3 +2113,15 @@
    set fan1_min 2000
    set fan2_min 2000
    set fan3_min 2000
+
+chip "adm1030-*"
+label temp1_input "SYS Temp"
+label temp2_input "CPU Temp"
+label fan1_input "CPU Fan"
+
+chip "adm1031-*"
+label temp1_input "SYS Temp"
+label temp2_input "CPU Temp1"
+label temp3_input "CPU Temp2"
+label fan1_input "Fan1"
+label fan2_input "Fan2"

Please indent the same way the other sections are. You forgot to remove
the "_input" suffixes.

diff -urN -x CVS lm_sensors2/lib/chips.c lm_sensors2_mine/lib/chips.c
--- lm_sensors2/lib/chips.c	2004-04-24 10:10:48.000000000 +0200
+++ lm_sensors2_mine/lib/chips.c	2004-05-17 14:10:30.000000000 +0200
@@ -360,6 +360,90 @@
+    { SENSORS_ADM1031_FAN1, "fan1_input", NOMAP, 
+                              NOMAP, R, 
+                              ADM1031_SYSCTL_FAN1, VALUE(2), 0 },

Here too you forgot to remove "_input". Same for the adm1031 right below.

diff -urN -x CVS lm_sensors2/prog/sensors/chips.c lm_sensors2_mine/prog/sensors/chips.c
--- lm_sensors2/prog/sensors/chips.c	2004-05-08 14:24:16.000000000 +0200
+++ lm_sensors2_mine/prog/sensors/chips.c	2004-05-17 17:12:46.000000000 +0200
+  for(i=0; i<(is_1031?2:1);i++) {
+      if (!sensors_get_label_and_valid(*name, SENSORS_ADM1031_FAN1,
+				       &label, &valid)

You always get fan1 label.

+	  && !sensors_get_feature(*name, SENSORS_ADM1031_FAN1+i*2, &cur)
+	  && !sensors_get_feature(*name, SENSORS_ADM1031_FAN1_MIN+i*2, &low)
+	  ) {
+	  if (valid) {
+	      print_label(label, 10);
+	      printf("%4.0f RPM  (min = %4.0f )", cur, low);

"RPM" missing for low limit.

The rest of it looks good to me.

Thanks.

-- 
Jean Delvare
http://khali.linux-fr.org/
