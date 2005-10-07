From: khali@linux-fr.org (Jean Delvare)
Date: Fri, 07 Oct 2005 19:56:11 +0000
Subject: [lm-sensors] sensors with uclibc (without iconv)
Message-Id: <20051007195453.0844cfea.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Bela, Rene, Robert,

It seems that you all would like sensors to compile on uclibc-based
systems, where iconv is not available. Attached is a patch which does
just that. It's basically the same as Rene proposed in ticket #2049,
except that detection is automatic. Please test. If it is actually OK
I'll apply it to lm_sensors CVS.

Thanks,
-- 
Jean Delvare
-------------- next part --------------
? prog/sensors/chips.rd
? prog/sensors/chips.ro
? prog/sensors/main.rd
? prog/sensors/main.ro
? prog/sensors/sensors
Index: prog/sensors/main.c
=================================RCS file: /home/cvs/lm_sensors2/prog/sensors/main.c,v
retrieving revision 1.112
diff -u -r1.112 main.c
--- prog/sensors/main.c	25 Sep 2005 13:31:53 -0000	1.112
+++ prog/sensors/main.c	7 Oct 2005 17:42:23 -0000
@@ -24,7 +24,11 @@
 #include <errno.h>
 #include <locale.h>
 #include <langinfo.h>
+
+#ifndef __UCLIBC__
 #include <iconv.h>
+#define HAVE_ICONV
+#endif
 
 #include "lib/sensors.h" 
 #include "lib/error.h"
@@ -116,11 +120,13 @@
 
 static void set_degstr(void)
 {
+  const char *deg_default_text[2] = {" C", " F"};
+
+#ifdef HAVE_ICONV
   /* Size hardcoded for better performance.
      Don't forget to count the trailing \0! */
   size_t deg_latin1_size = 3;
   char *deg_latin1_text[2] = {"\260C", "\260F"};
-  const char *deg_default_text[2] = {" C", " F"};
   size_t nconv;
   size_t degstr_size = sizeof(degstr);
   char *degstr_ptr = degstr;
@@ -134,6 +140,7 @@
     if (nconv != (size_t) -1)
       return;	   
   }
+#endif /* HAVE_ICONV */
 
   /* There was an error during the conversion, use the default text */
   strcpy(degstr, deg_default_text[fahrenheit]);
