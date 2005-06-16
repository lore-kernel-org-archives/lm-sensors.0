From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 16 Jun 2005 21:55:49 +0000
Subject: [lm-sensors] fixing ticket #1944
Message-Id: <20050616215454.3e4d7e5a.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050615222035.91224.qmail@web31003.mail.mud.yahoo.com>
In-Reply-To: <20050615222035.91224.qmail@web31003.mail.mud.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Hugo,

> It looks right. I normally run my own programs that
> are like sensors, using libsensors. What do I have to
> do to get those to work? I will take a look at the
> sensors code.

Patch attached. It was quite easy as you can see. Of course, after we
have a datasheet and know the differences between the W83627THF and the
W83687THF chips, there will probably be some adjustments needed.

-- 
Jean Delvare
-------------- next part --------------
Index: lib/chips.h
=================================RCS file: /home/cvs/lm_sensors2/lib/chips.h,v
retrieving revision 1.108
diff -u -r1.108 chips.h
--- lib/chips.h	1 Jun 2005 10:49:04 -0000	1.108
+++ lib/chips.h	16 Jun 2005 20:17:33 -0000
@@ -575,6 +575,7 @@
 #define SENSORS_W83627HF_PREFIX "w83627hf"
 #define SENSORS_W83627THF_PREFIX "w83627thf"
 #define SENSORS_W83637HF_PREFIX "w83637hf"
+#define SENSORS_W83687THF_PREFIX "w83687thf"
 
 #define SENSORS_W83791D_PREFIX "w83791d"
 
Index: lib/chips.c
=================================RCS file: /home/cvs/lm_sensors2/lib/chips.c,v
retrieving revision 1.168
diff -u -r1.168 chips.c
--- lib/chips.c	1 Jun 2005 10:49:04 -0000	1.168
+++ lib/chips.c	16 Jun 2005 20:17:35 -0000
@@ -5436,6 +5436,7 @@
  { SENSORS_W83627THF_PREFIX, w83782d_features },
 		/* Cheat on 83637HF for now - no separate #defines */
  { SENSORS_W83637HF_PREFIX, w83782d_features },
+ { SENSORS_W83687THF_PREFIX, w83782d_features }, /* Same as W83687THF */
  { SENSORS_W83791D_PREFIX, w83791d_features },
  { SENSORS_W83792D_PREFIX, w83792d_features },
  { SENSORS_W83L785TS_PREFIX, w83l785ts_features },
Index: prog/sensors/chips.c
=================================RCS file: /home/cvs/lm_sensors2/prog/sensors/chips.c,v
retrieving revision 1.161
diff -u -r1.161 chips.c
--- prog/sensors/chips.c	6 Jun 2005 19:22:52 -0000	1.161
+++ prog/sensors/chips.c	16 Jun 2005 20:17:36 -0000
@@ -2201,10 +2201,12 @@
   is82d = (!strcmp(name->prefix,"w83782d")) ||
           (!strcmp(name->prefix,"w83627hf")) ||
           (!strcmp(name->prefix,"w83637hf")) ||
-          (!strcmp(name->prefix,"w83627thf"));
+          (!strcmp(name->prefix,"w83627thf")) ||
+          (!strcmp(name->prefix,"w83687thf"));
   is83s = !strcmp(name->prefix,"w83783s");
   is627thf = (!strcmp(name->prefix,"w83627thf")) ||
-             (!strcmp(name->prefix,"w83637hf"));
+             (!strcmp(name->prefix,"w83637hf")) ||
+	     (!strcmp(name->prefix,"w83687thf"));
   is697hf  = !strcmp(name->prefix,"w83697hf");
 
   if (!sensors_get_feature(*name,SENSORS_W83781D_ALARMS,&cur)) 
Index: prog/sensors/main.c
=================================RCS file: /home/cvs/lm_sensors2/prog/sensors/main.c,v
retrieving revision 1.111
diff -u -r1.111 main.c
--- prog/sensors/main.c	27 Mar 2005 15:44:53 -0000	1.111
+++ prog/sensors/main.c	16 Jun 2005 20:17:36 -0000
@@ -361,6 +361,7 @@
 	{ "w83627thf", print_w83781d },
 	{ "w83637hf", print_w83781d },
 	{ "w83697hf", print_w83781d },
+	{ "w83687thf", print_w83781d },
 	{ "w83627ehf", print_w83627ehf },
 	{ "w83791d", print_w83781d },
         { "w83792d", print_w83792d },
