From: decibel8@charter.net (David)
Date: Thu, 19 May 2005 06:24:02 +0000
Subject: 1250
Message-Id: <200306261808.58563.decibel8@charter.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <200306021011.37032.decibel8@charter.net>
In-Reply-To: <200306021011.37032.decibel8@charter.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean,
	I will try putting the CVS on tonight. For now though here is the info
you were interested on about the patch.


> > SRC_URI="http://www2.lm-sensors.nu/~lm78/archive/${MY_P}.tar.gz
> > 	mirror://gentoo/${P}-sensors-detect-gentoo.diff.bz2"
>
> BTW, what's this patch? I'd like to know what Gentoo changed in our
> original sensors-detect script.

This looks relitively new. I remember the first time I installed lm-sensors I had to make
the /etc/sysconfig folder and put the stuff there. So they just fixed that for the
Gentoo layout, which doesn't have that folder. Then /etc/init.d is the
run scripts for daemons and such you start/stop.  

*************************************************************
diff -urN lm_sensors-2.7.0-orig/prog/detect/sensors-detect lm_sensors-2.7.0/prog/detect/sensors-detect
--- lm_sensors-2.7.0-orig/prog/detect/sensors-detect	2003-03-02 01:26:59.000000000 +0100
+++ lm_sensors-2.7.0/prog/detect/sensors-detect	2003-03-02 02:42:16.000000000 +0100
@@ -25,6 +25,14 @@
 # each be put in a separate file, using modules and packages. That is beyond
 # me.

+# Changelog
+#  02/Mar/2003, Rudo Thomas <thomr9am@ss1000.ms.mff.cuni.cz>
+#    * a few small changes in config file output to reflect Gentoo Linux layout
+#      - /etc/sysconfig -> /etc/conf.d
+#      - /etc/rc.d/init.d -> /etc/init.d
+#      - added a warning to the generated config file
+#      - small change when asking about writing the new config file
+
 require 5.004;

 use strict;
@@ -3277,33 +3285,38 @@
   my ($modprobes,$configfile) = generate_modprobes $use_isa;
   print "\nWARNING! If you have some things built into your kernel, the \n",
         "below list will contain too many modules. Skip the appropriate ones!";
-  print "\nTo load everything that is needed, add this to some /etc/rc* ",
-        "file:\n\n";
+  print "\nTo load everything that is needed, execute these commands:\n\n";
   print "#----cut here----\n";
   print $modprobes;
   print "#----cut here----\n";
-  print "\nTo make the sensors modules behave correctly, add these lines to ",
-        "either\n",
-        "/etc/modules.conf or /etc/conf.modules:\n\n";
+  print "\nIf you want to load the modules at startup, generate a config",
+  	" file\n",
+	"below and make sure lm_sensors get started ",
+	"(eg. rc-update add lm_sensors default).\n";
+  print "\nTo make the sensors modules behave correctly, add these lines to\n",
+        "/etc/modules.conf:\n\n";
   print "#----cut here----\n";
   print $configfile;
   print "#----cut here----\n";

-  my $have_sysconfig = -d '/etc/sysconfig';
-  print "\nDo you want to generate /etc/sysconfig/lm_sensors? (".
-    ($have_sysconfig?"YES/no":"yes/NO")."): ";
-  if ($> != 0) {
-    print "\nAs you are not root, we shall skip this step.\n";
-  } else {
-    if (($have_sysconfig and not <STDIN> =~ /^\s*[Nn]/) or <STDIN> =~ /^\s*[Yy]/) {
-      unless ($have_sysconfig) {
-        mkdir '/etc/sysconfig', 0777
-          or die "Sorry, can't create /etc/sysconfig ($!)?!?";
-      }
-      open(SYSCONFIG, ">/etc/sysconfig/lm_sensors")
-        or die "Sorry, can't create /etc/sysconfig/lm_sensors ($!)?!?";
+  my $have_config = -f '/etc/conf.d/lm_sensors';
+  print "\nDo you want to ".($have_config?"overwrite":"generate").
+  	" /etc/conf.d/lm_sensors? Enter s to specify other file name?\n",
+	"  (".($have_config?"yes/NO":"YES/no")."/s): ";
+  my $reply = <STDIN>;
+
+  if (($have_config and $reply =~ /^\s*[Yy]/) or
+      (not $have_config and not $reply =~ /^\s*[Nn]/) or
+      $reply =~ /^\s*[Ss]/) {
+    my $filename = "/etc/conf.d/lm_sensors";
+    if ($reply =~ /^\s*[Ss]/) {
+      print "Specify the file to store the configuration to: ";
+      $filename = <STDIN>;
+    }
+    open(SYSCONFIG, ">".$filename)
+      or die "Sorry, can't create $filename ($!).";
       print SYSCONFIG <<'EOT';
-#    /etc/sysconfig/sensors - Defines modules loaded by /etc/rc.d/init.d/lm_sensors
+#    /etc/conf.d/sensors - Defines modules loaded by /etc/init.d/lm_sensors
 #    Copyright (c) 1998 - 2001  Frodo Looijaard <frodol@dds.nl>
 #
 #    This program is free software; you can redistribute it and/or modify
@@ -3324,13 +3337,17 @@
 # See also the lm_sensors homepage at:
 #     http://www2.lm-sensors.nu/~lm78/index.html
 #
-# This file is used by /etc/rc.d/init.d/lm_sensors and defines the modules to
-# be loaded/unloaded. This file is sourced into /etc/rc.d/init.d/lm_sensors.
+# This file is used by /etc/init.d/lm_sensors and defines the modules to
+# be loaded/unloaded. This file is sourced into /etc/init.d/lm_sensors.
 #
 # The format of this file is a shell script that simply defines the modules
 # in order as normal variables with the special names:
 #    MODULE_0, MODULE_1, MODULE_2, etc.
 #
+# Please note that the numbers in MODULE_X must start at 0 and increase in
+# steps of 1. Any number that is missing will make the init script skip the
+# rest of the modules.
+#
 # List the modules that are to be loaded for your system
 #
 EOT
@@ -3346,9 +3363,7 @@
       }
       print SYSCONFIG $sysconfig;
       close(SYSCONFIG);
-      print "Copy prog/init/lm_sensors.init to /etc/rc.d/init.d/lm_sensors\n";
-      print "for initialization at boot time.\n";
-    }
+      print "Done.\n";
   }
 }
*************************************************

> I of course meant echo, not cat :)
Ya, I never seen cat used that way, but you always see someone using a 
command in a new way, so I though hmmm, let's try it. :)

Get back with you on the CVS in awhile.

David

Original message:

On Thursday 26 June 2003 08:40 am, you wrote:
> > Sorry, must have hit send. Anyways.
>
> Well, that happens to *me* also sometimes ;)
>
> > > This would make sense. David, correct me if I'm wrong, but I believe
> > > that you can actually write to the files (simply using "cat 1 2 >
> > > /proc/sys/dev/sensors/via686a-isa-6000/in1" for example). So, if
> > > "sensors -s" fails, this must be because of libsensors *thinking* it
> > > cannot write.
> >
> > Actually no. Not using cat. I get this error if do that:
> >
> > bash-2.05b# cat 1 2 > /proc/sys/dev/sensors/via686a-isa-6000/in1
> > cat: 1: No such file or directory
> > cat: 2: No such file or directory
> >
> > I can though 'echo' to it:
> > bash-2.05b# echo 1 2 > /proc/sys/dev/sensors/via686a-isa-6000/in1
> > Haven't done that before though so not sure why it changed it to:
> > 0.99 1.99 1.07
> > from the defaults in there. Doesn't matter now though. Root can write
> > to the file using 'echo'
>
> (hitting me head on the table) I of course meant echo, not cat :) Glad
> you figured it out by yourself.
>
> > > 1* Are you using i2c & lm_sensors 2.7.0 or CVS?
> >
> > 2.7.0 both, not CVS.
>
> Could you possibly give a try to CVS? It could be interesting to see if
> the problem could have been already been solved as a side effect of
> another fix.
>
> > > 2* Are you using the mkpatch method or the traditional separated
> > > compilation tree method?
> >
> > Not sure, Probably closer to the 2nd one. I could try not using the
> > ebuild below if you think it might be the problem.
>
> I think you're right, 2nd method. I don't think it changes anything that
> you use ebuild (except that you may not be able to use it for CVS).
>
> > SRC_URI="http://www2.lm-sensors.nu/~lm78/archive/${MY_P}.tar.gz
> > 	mirror://gentoo/${P}-sensors-detect-gentoo.diff.bz2"
>
> BTW, what's this patch? I'd like to know what Gentoo changed in our
> original sensors-detect script.
>
> Thanks.
