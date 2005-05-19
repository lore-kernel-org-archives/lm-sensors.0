From: aurelien@aurel32.net (Aurelien Jarno)
Date: Thu, 19 May 2005 06:24:48 +0000
Subject: [PATCH] sensors: print the degree sign in the terminal's current
Message-Id: <20040321013630.GA28378@pc.aurel32.private>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi all,

To print the degree sign, sensors lookups the current locale, outputs it
in UTF-8 if the locale is in UTF-8, and in latin-1 otherwise. However
some people are using other locales. Moreover, it is rather irritating
for people using a Japanese locale, as the character code 176 is a start
of sequence of characters for EUC terminals.

The attached patch uses iconv to convert the degree sign in an UTF-8
format to the current locale.

Aurelien


-- 
  .''`.  Aurelien Jarno	              GPG: 1024D/F1BCDB73
 : :' :  Debian GNU/Linux developer | Electrical Engineering Student 
 `. `'   aurel32@debian.org         | aurelien@aurel32.net
   `-    people.debian.org/~aurel32 | www.aurel32.net
-------------- next part --------------
Index: prog/sensors/main.c
=================================RCS file: /home/cvs/lm_sensors2/prog/sensors/main.c,v
retrieving revision 1.90
diff -u -1 -b -p -r1.90 main.c
--- lm_sensors2.orig/prog/sensors/main.c	29 Feb 2004 18:43:53 -0000	1.90
+++ lm_sensors2/prog/sensors/main.c	21 Mar 2004 00:51:01 -0000
@@ -26,2 +26,3 @@
 #include <langinfo.h>
+#include <iconv.h>
 
@@ -156,2 +157,34 @@ void close_config_file(void)
 
+void set_degstr(void)
+{
+  /* Size hardcoded for better performance. Don't forget to count \0 !!! */
+  size_t deg_utf8_size = 4;
+  char *deg_utf8_celsius = "??C";
+  char *deg_utf8_farenheit = "??F";
+  size_t nconv;
+  size_t degstr_size = sizeof(degstr);
+  char *degstr_ptr = degstr;
+  
+  iconv_t cd = iconv_open(nl_langinfo(CODESET), "UTF-8");
+  if (cd = (iconv_t) -1)
+    goto conv_error;
+  
+  if (fahrenheit) 
+    nconv = iconv(cd, &deg_utf8_farenheit, &deg_utf8_size, &degstr_ptr, &degstr_size);
+  else
+    nconv = iconv(cd, &deg_utf8_celsius, &deg_utf8_size, &degstr_ptr, &degstr_size);
+  iconv_close(cd);
+  
+  if (nconv = (size_t) -1)
+    goto conv_error;
+
+  return;
+  
+conv_error:
+  if (fahrenheit) 
+    strcpy(degstr, " F");
+  else
+    strcpy(degstr, " C");
+}
+
 int main (int argc, char *argv[])
@@ -255,11 +288,3 @@ int main (int argc, char *argv[])
   /* build the degrees string */
-  if (strcmp(nl_langinfo(CODESET), "UTF-8") = 0)
-    sprintf(degstr, "%c%c", 0xc2, 0xb0);
-  else
-    sprintf(degstr, "%c", 176);
-  if (fahrenheit) {
-    strcat(degstr, "F");
-  } else {
-    strcat(degstr, "C");
-  }
+  set_degstr();
 
