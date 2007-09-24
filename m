From: Aurelien Jarno <aurelien@aurel32.net>
Date: Mon, 24 Sep 2007 08:26:13 +0000
Subject: [lm-sensors] [PATCH] Remove error message if die-code is missing
Message-Id: <20070924082613.GA2787@hall.aurel32.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi all,

The simple patch below removes the error message if the die-code entry
is missing in /sys. It has been removed from the 2.6 kernels for a long
time.

It is still present for 2.4 kernels though, so we should keep the code
reading this entry.

Regards,
Aurelien

Index: prog/sensors/chips.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D--- prog/sensors/chips.c	(r=E9vision 4862)
+++ prog/sensors/chips.c	(copie de travail)
@@ -261,8 +261,7 @@
         print_label(label,10);
         printf("%4.0f\n",cur);
       }
-    } else
-      printf("ERROR: Can't get die-code data!\n");
+    }
     free(label);
   }
 }

--=20
  .''`.  Aurelien Jarno	            | GPG: 1024D/F1BCDB73
 : :' :  Debian developer           | Electrical Engineer
 `. `'   aurel32@debian.org         | aurelien@aurel32.net
   `-    people.debian.org/~aurel32 | www.aurel32.net

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
