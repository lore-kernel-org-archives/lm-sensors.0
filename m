From: Jean Delvare <khali@linux-fr.org>
Date: Fri, 05 Jun 2009 13:40:23 +0000
Subject: Re: [lm-sensors] [PATCH] bug in sensors.d reading: not all
Message-Id: <20090605154023.607b62bd@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <h09l4i$sdc$1@ger.gmane.org>
In-Reply-To: <h09l4i$sdc$1@ger.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi Yuriy,

On Fri, 05 Jun 2009 03:25:06 +0400, Yuriy Kaminskiy wrote:
> Hello!
>   Most filesystems (in particular - reiserfs, jfs, xfs, nfs); maybe,
> some legacy installation of ext2/3 too) always return dirent->dt_type > D=
T_UNKNOWN, so libsensors fails to parse /etc/sensors.d.
>   Also, symlink (DT_LNK) can point to directory, or FIFO/socket/device
> (very bad!) - current check insufficient anyways.
>   I've attached [somewhat hackerish] patch to solve both problem.
> =3D=3D cut !man 3 readdir =3D> Currently,  only  some  file systems (amon=
g them: ext2, etx3, and ext4)
> have full support returning the file type in d_type.  All  applications
> must properly handle a return of DT_UNKNOWN.
> =3D=3D cut =3D
Thanks for reporting, I had totally missed the fact that not all
filesystems implemented this interface.

>   Maybe, it would be better to remove dt_type check and use stat() always.

Yes, I think so. I don't much like the complexity of your proposed
solution. The problem is simple, it should have a simple solution.
Performance isn't critical for this part of the code, what matters is
robustness and readability.

What about the simplified version below?

Index: lib/init.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D--- lib/init.c	(r=E9vision 5729)
+++ lib/init.c	(copie de travail)
@@ -23,12 +23,14 @@
 #define _BSD_SOURCE
=20
 #include <sys/types.h>
+#include <sys/stat.h>
 #include <locale.h>
 #include <stdlib.h>
 #include <stdio.h>
 #include <string.h>
 #include <errno.h>
 #include <dirent.h>
+#include <unistd.h>
 #include "sensors.h"
 #include "data.h"
 #include "error.h"
@@ -120,8 +122,7 @@
=20
 static int config_file_filter(const struct dirent *entry)
 {
-	return (entry->d_type =3D DT_REG || entry->d_type =3D DT_LNK)
-	    && entry->d_name[0] !=3D '.';		/* Skip hidden files */
+	return entry->d_name[0] !=3D '.';		/* Skip hidden files */
 }
=20
 static int add_config_from_dir(const char *dir)
@@ -143,6 +144,7 @@
 		int len;
 		char path[PATH_MAX];
 		FILE *input;
+		struct stat st;
=20
 		len =3D snprintf(path, sizeof(path), "%s/%s", dir,
 			       namelist[i]->d_name);
@@ -151,6 +153,10 @@
 			continue;
 		}
=20
+		/* Only accept regular files */
+		if (stat(path, &st) < 0 || !S_ISREG(st.st_mode))
+			continue;
+
 		input =3D fopen(path, "r");
 		if (input) {
 			res =3D parse_config(input, path);


--=20
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
