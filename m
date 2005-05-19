From: aurelien@aurel32.net (Aurelien Jarno)
Date: Thu, 19 May 2005 06:24:55 +0000
Subject: w83781d and alarms for temp2 and temp3
Message-Id: <20040501224829.GA13732@pc.aurel32.lan>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi all !

I found a small bug in sensors and sensord when used with a w83781d
chip. On this chip the alarms for temp2 and temp3 are merged. However
that is not handled in sensors and sensord.

Please find attached a preliminary patch against the current CVS for 
sensors.

Concerning sensord the patch would be a little bit more complicated as
the code is shared with the as99127f. I first wanted to know if the
as99127f behaves as the w83781d. If somebody could test that it would be
great. The test is simple: set beep_mask to 0x2000, and see if "(beep)"
is printed on the temp3 line.

Bye,
Aurelien


-- 
  .''`.  Aurelien Jarno	              GPG: 1024D/F1BCDB73
 : :' :  Debian GNU/Linux developer | Electrical Engineering Student 
 `. `'   aurel32@debian.org         | aurelien@aurel32.net
   `-    people.debian.org/~aurel32 | www.aurel32.net
-------------- next part --------------
diff -ru lm_sensors2.orig/prog/sensors/chips.c lm_sensors2/prog/sensors/chips.c
--- lm_sensors2.orig/prog/sensors/chips.c	2004-05-02 00:23:03.000000000 +0200
+++ lm_sensors2/prog/sensors/chips.c	2004-05-02 00:22:38.000000000 +0200
@@ -2346,8 +2346,12 @@
         if(!is82d) {
           print_label(label,10);
           print_temp_info( cur, max, min, HYST, 1, 0);
-          printf(" %s  %s\n", alarms&W83781D_ALARM_TEMP3 ?"ALARM":"     ",
-                 beeps&W83781D_ALARM_TEMP3?"(beep)":"");
+          if (!is81d)
+            printf(" %s  %s\n", alarms&W83781D_ALARM_TEMP3 ?"ALARM":"     ",
+                   beeps&W83781D_ALARM_TEMP3?"(beep)":"");
+          else
+            printf(" %s  %s\n", alarms&W83781D_ALARM_TEMP23 ?"ALARM":"     ",
+                   beeps&W83781D_ALARM_TEMP23?"(beep)":"");
         } else {
           if(!sensors_get_feature(*name,SENSORS_W83781D_SENS3,&sens)) {
             print_label(label,10);
