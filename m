From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 18 Feb 2008 21:33:17 +0000
Subject: [lm-sensors] [PATCH] sensors-detect: Skip "random" I/O port probing
Message-Id: <20080218223317.2142dc16@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi all,

As a follow-up of this discussion on LKML:
  http://lkml.org/lkml/2008/2/13/390
I would like to propose the following patch to sensors-detect:

Index: prog/detect/sensors-detect
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D--- prog/detect/sensors-detect	(r=E9vision 5123)
+++ prog/detect/sensors-detect	(copie de travail)
@@ -3,7 +3,7 @@
 #
 #    sensors-detect - Detect PCI bus and chips
 #    Copyright (C) 1998 - 2002  Frodo Looijaard <frodol@dds.nl>
-#    Copyright (C) 2004 - 2007  Jean Delvare <khali@linux-fr.org>
+#    Copyright (C) 2004 - 2008  Jean Delvare <khali@linux-fr.org>
 #
 #    This program is free software; you can redistribute it and/or modify
 #    it under the terms of the GNU General Public License as published by
@@ -2366,12 +2366,13 @@
 # [2] -> SUBLEVEL
 # [3] -> EXTRAVERSION
 #
-use vars qw(@kernel_version);
+use vars qw(@kernel_version $kernel_arch);
=20
 sub initialize_kernel_version
 {
   `uname -r` =3D~ /(\d+)\.(\d+)\.(\d+)(.*)/;
   @kernel_version =3D ($1, $2, $3, $4);
+  $kernel_arch =3D `uname -m`;
 }
=20
 sub kernel_version_at_least
@@ -5810,27 +5811,32 @@
   }
   print "\n";
=20
-  print "Some chips are also accessible through the ISA I/O ports. We have=
 to\n".
-        "write to arbitrary I/O ports to probe them. This is usually safe =
though.\n".
-        "Yes, you do have ISA I/O ports even if you do not have any ISA sl=
ots!\n";
-  print "Do you want to scan the ISA I/O ports? (YES/no): ";
-  unless (<STDIN> =3D~ /^\s*n/i) {
-    initialize_ioports();
-    scan_isa_bus();
-    close_ioports();
-  }
-  print "\n";
+  # Skip "random" I/O port probing on PPC
+  if ($kernel_arch ne 'ppc'
+   && $kernel_arch ne 'ppc64'
+   && $kernel_arch ne 'powerpc') {
+    print "Some chips are also accessible through the ISA I/O ports. We ha=
ve to\n".
+          "write to arbitrary I/O ports to probe them. This is usually saf=
e though.\n".
+          "Yes, you do have ISA I/O ports even if you do not have any ISA =
slots!\n";
+    print "Do you want to scan the ISA I/O ports? (YES/no): ";
+    unless (<STDIN> =3D~ /^\s*n/i) {
+      initialize_ioports();
+      scan_isa_bus();
+      close_ioports();
+    }
+    print "\n";
=20
-  print "Some Super I/O chips may also contain sensors. We have to write t=
o\n".
-        "standard I/O ports to probe them. This is usually safe.\n";
-  print "Do you want to scan for Super I/O sensors? (YES/no): ";
-  unless (<STDIN> =3D~ /^\s*n/i) {
-    initialize_ioports();
-    scan_superio(0x2e, 0x2f);
-    scan_superio(0x4e, 0x4f);
-    close_ioports();
+    print "Some Super I/O chips may also contain sensors. We have to write=
 to\n".
+          "standard I/O ports to probe them. This is usually safe.\n";
+    print "Do you want to scan for Super I/O sensors? (YES/no): ";
+    unless (<STDIN> =3D~ /^\s*n/i) {
+      initialize_ioports();
+      scan_superio(0x2e, 0x2f);
+      scan_superio(0x4e, 0x4f);
+      close_ioports();
+    }
+    print "\n";
   }
-  print "\n";
=20
   print "Some CPUs or memory controllers may also contain embedded sensors=
.\n";
   print "Do you want to scan for them? (YES/no): ";

The idea is to skip "random" I/O port probing on PPC, as it won't find
anything anyway and can cause the kernel to oops.

Christian, can you please test this patch and confirm that it solves
your problem?

Ben, can you please comment on this patch? I'm not familiar with the
PPC architecture at all so I'm not sure if I am looking for the right
strings.

Thanks,
--=20
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
