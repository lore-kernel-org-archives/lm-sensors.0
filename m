From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:23:34 +0000
Subject: suggested -V flag for sensors
Message-Id: <20020605225802.4fe9ecfe.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20020525104152.0a2701df.khali@linux-fr.org>
In-Reply-To: <20020525104152.0a2701df.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> People send us a lot of 'sensors' output and without the algo/adap
> info it would be a lot harder to diagnose things, or we would have to
> ask them to use -V, so I'd rather not take that info out by default.
> If you want to submit a -A patch (including a man page update) I'll 
> apply it.
> thanks
> mds

Here is my patch.

Some additional notes:

This patch also fixes a bug with the --unknown command line switch,
which was waiting for an argument it doesn't actually need.

I suggest a change for the manual page, from "Linux Programmer's Manual"
to "Linux User's Manual" (My patch doesn't change this... This is only a
suggestion.)

As usual, I am open to any suggestion, comment...
Thanks.

-- 
Jean "Khali" Delvare
http://www.ensicaen.ismra.fr/~delvare/
-------------- next part --------------
diff -ruN lm_sensors-2.6.3/prog/sensors/main.c lm_sensors-2.6.3-hideaa/prog/sensors/main.c
--- lm_sensors-2.6.3/prog/sensors/main.c	Wed Jan  9 02:19:23 2002
+++ lm_sensors-2.6.3-hideaa/prog/sensors/main.c	Sat Jun  1 17:49:15 2002
@@ -52,7 +52,7 @@
 #define CHIPS_MAX 20
 sensors_chip_name chips[CHIPS_MAX];
 int chips_count=0;
-int do_sets, do_unknown, fahrenheit;
+int do_sets, do_unknown, fahrenheit, hide_adapter;
 
 void print_short_help(void)
 {
@@ -65,7 +65,8 @@
   printf("  -c, --config-file     Specify a config file\n");
   printf("  -h, --help            Display this help text\n");
   printf("  -s, --set             Execute `set' statements too (root only)\n");
-  printf("  -f, --fahrenheit      Show temperatures in degrees fahrenheit\n" );
+  printf("  -f, --fahrenheit      Show temperatures in degrees fahrenheit\n");
+  printf("  -A, --no-adapter      Do not show adapter and algorithm for each chip\n");
   printf("  -u, --unknown         Treat chips as unknown ones (testing only)\n");
   printf("  -v, --version         Display the program version\n");
   printf("\n");
@@ -147,15 +148,17 @@
     { "set", no_argument, NULL, 's' },
     { "version", no_argument, NULL, 'v'},
     { "fahrenheit", no_argument, NULL, 'f' },
+    { "no-adapter", no_argument, NULL, 'A' },
     { "config-file", required_argument, NULL, 'c' },
-    { "unknown", required_argument, NULL, 'u' },
+    { "unknown", no_argument, NULL, 'u' },
     { 0,0,0,0 }
   };
 
   do_unknown = 0;
   do_sets = 0;
+  hide_adapter = 0;
   while (1) {
-    c = getopt_long(argc,argv,"hvufsc:",long_opts,NULL);
+    c = getopt_long(argc,argv,"hsvfAcu:",long_opts,NULL);
     if (c = EOF)
       break;
     switch(c) {
@@ -178,6 +181,9 @@
     case 'f':
       fahrenheit = 1;
       break;
+    case 'A':
+      hide_adapter = 1;
+      break;
     case 'u':
       do_unknown = 1;
       break;
@@ -279,10 +285,10 @@
 
   printf("%s\n",sprintf_chip_name(name));
   adap = sensors_get_adapter_name(name.bus);
-  if (adap)
+  if (adap && !hide_adapter)
     printf("Adapter: %s\n",adap);
   algo = sensors_get_algorithm_name(name.bus);
-  if (algo)
+  if (algo && !hide_adapter)
     printf("Algorithm: %s\n",algo);
   if (!algo || !adap)
     printf(" ERROR: Can't get adapter or algorithm?!?\n");
diff -ruN lm_sensors-2.6.3/prog/sensors/sensors.1 lm_sensors-2.6.3-hideaa/prog/sensors/sensors.1
--- lm_sensors-2.6.3/prog/sensors/sensors.1	Mon Nov 13 19:31:48 2000
+++ lm_sensors-2.6.3-hideaa/prog/sensors/sensors.1	Sun Jun  2 09:51:59 2002
@@ -21,7 +21,7 @@
 .\" Formatted or processed versions of this manual, if unaccompanied by
 .\" the source, must acknowledge the copyright and authors of this work.
 .\"
-.TH sensors 1  "February 8, 1999" "" "Linux Programmer's Manual"
+.TH sensors 1  "June 2, 2002" "" "Linux Programmer's Manual"
 .SH NAME
 sensors \- printing sensors information
 .SH SYNOPSIS
@@ -59,6 +59,8 @@
 Evaluates all `set' statements in the configuration file. You must probably
 be `root' to do this. If this parameter is not specified, no `set' statement
 is evaluated.
+.IP -A
+Do not show adapter and algorithm for each chipset.
 .IP -u
 Treats all chips as unknown ones. Output will be of much lower quality;
 this option is only added for testing purposes.
