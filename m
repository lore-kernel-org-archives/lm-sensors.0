From: paolo.berva@st.com (Paolo Cesare BERVA)
Date: Thu, 19 May 2005 06:24:37 +0000
Subject: Sensors on K7S5A and kernel 2.6.1
Message-Id: <401526A5.30908@st.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi, lm_sensors v2.8.3 and linux kernel 2.6.1 on mainboard K7S5A v3.1
(chip type it87), after some trouble, works like a charm.

I encountred a problem listed in the FAQ at section 4.27.
Looking at the code in progs/sensors/chips.c and putting some debugging lines 
into it I found that the functions
sensors_get_feature(*name,SENSORS_IT87_TEMP1_LOW,&min),
sensors_get_feature(*name,SENSORS_IT87_TEMP2_LOW,&min)
sensors_get_feature(*name,SENSORS_IT87_TEMP3_LOW,&min)
  returns SENSORS_ERR_PROC.
In the sysfs pseudo filesystem I can read the temperature values.
So I made some modification to lib/chips.c to fix the trouble.
You can see the diff file at the end of this e-mail.
I had to change also the lines in sensors.conf
#    from                    to
#========================#    set   temp2_hyst  20    set   temp2_min  20
#    set   temp3_hyst  25    set   temp3_min  25

in order to resolve what in FAQ at item 4.25 Sensors says Error: Line xxx: zzzzzzz

I'm not sure if this is the right way to get it working. May be (I'm sure) you 
have a better solution.

Thank you for your good work on lm_sensors project.
Paolo


  --- lib/chips.c Sun Jan 25 00:13:49 2004
+++ ../lm_sensors-2.8.3.OK/lib/chips.c  Sat Jan 24 01:23:43 2004
@@ -3757,13 +3757,13 @@
                           R, IT87_SYSCTL_TEMP2, VALUE(3), 1 },
      { SENSORS_IT87_TEMP3, "temp3", NOMAP, NOMAP,
                           R, IT87_SYSCTL_TEMP3, VALUE(3), 1 },
-    { SENSORS_IT87_TEMP1_LOW, "temp1_hyst", SENSORS_IT87_TEMP1,
+    { SENSORS_IT87_TEMP1_LOW, "temp1_min", SENSORS_IT87_TEMP1,
                                SENSORS_IT87_TEMP1, RW,
                                IT87_SYSCTL_TEMP1, VALUE(2), 1 },
-    { SENSORS_IT87_TEMP2_LOW, "temp2_hyst", SENSORS_IT87_TEMP2,
+    { SENSORS_IT87_TEMP2_LOW, "temp2_min", SENSORS_IT87_TEMP2,
                                SENSORS_IT87_TEMP2, RW,
                                IT87_SYSCTL_TEMP2, VALUE(2), 1 },
-    { SENSORS_IT87_TEMP3_LOW, "temp3_hyst", SENSORS_IT87_TEMP3,
+    { SENSORS_IT87_TEMP3_LOW, "temp3_min", SENSORS_IT87_TEMP3,
                                SENSORS_IT87_TEMP3, RW,
                                IT87_SYSCTL_TEMP3, VALUE(2), 1 },
      { SENSORS_IT87_TEMP1_HIGH, "temp1_over", SENSORS_IT87_TEMP1,
