From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:26 +0000
Subject: Can't access /proc file for writing
Message-Id: <20031124210502.7bdacbc1.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <1067739926.5304.28.camel@hahasiah.rozsas.xx.nom.br>
In-Reply-To: <1067739926.5304.28.camel@hahasiah.rozsas.xx.nom.br>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi again Miguel,

Sorry for the delay, it took a while before I could get some spare time
to learn how to use strace. Now I know enough to help.

> The strace for "sensors -s" is attached.
> I hope you guys can figure out what is happening.
> I don't understand the strace either, but I saw several
> "Inappropriate ioctl for device" and "(Permission denied)"
> messages in the output.

The "Inappropriate ioctl for device" is normal (in the sense it also
happens on systems where "sensors -s" doesn't fail). The problem is with
the "(Permission denied)". That said, your strace output doesn't reveal
anything. The sysctl calls are failing, but it doesn't show why.

> Please, let me know if you need something else, ok ?

I do. As I was stracing sensors, I found and fixed a couple of problems,
mainly memory leaks. Also, other changes were made to support sysfs
(Linux 2.6). Although we did not explicitely fix your problem, there
might have been some side effects. So, I'd like you to check the latest
versions of i2c and lm_sensors2 out of CVS, and give it a try. Don't
forget to run "ldconfig" after installing lm_sensors, since the library
version changed.

With that new version installed, I'd like you to retry "sensors -s". If
it still doesn't work, I'd like you to provide the strace output anew.

If it isn't significantly different from the first time, please apply
the attached patch (move in lm_sensors2 and run "patch -p0 <
lib-proc.diff), compile again, install again, and strace again. It might
reveal something interesting.

> Many thanks for the help.

You're welcome. I hope we'll find something. If the operations above
don't lead us anywhere, there is another thing we might try. We'll see
then.

Thanks.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
-------------- next part --------------
Index: lib/proc.c
=================================RCS file: /home/cvs/lm_sensors2/lib/proc.c,v
retrieving revision 1.18
diff -u -r1.18 proc.c
--- lib/proc.c	24 Nov 2003 20:18:47 -0000	1.18
+++ lib/proc.c	24 Nov 2003 20:22:57 -0000
@@ -18,6 +18,7 @@
 */
 
 #include <stddef.h>
+#include <unistd.h>
 #include <stdio.h>
 #include <string.h>
 #include <sys/sysctl.h>
@@ -358,6 +359,10 @@
 			value /= 10.0;
 		* ((long *) (buf + the_feature->offset)) = (long) value;
 		buflen = the_feature->offset + sizeof(long);
+		getuid();
+		geteuid();
+		getgid();
+		getegid();
 		if (sysctl(sysctl_name, 4, NULL, 0, buf, buflen))
 			return -SENSORS_ERR_PROC;
 	}
