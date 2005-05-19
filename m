From: peb@mppmu.mpg.de (Peter Breitenlohner)
Date: Thu, 19 May 2005 06:24:54 +0000
Subject: i2c-1.8.4 and lm_sensors-2.8.5 -- a comment
Message-Id: <Pine.LNX.4.58.0404211102270.8811@pcl321.mppmu.mpg.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <Pine.LNX.4.58.0404201404510.1296@pcl321.mppmu.mpg.de>
In-Reply-To: <Pine.LNX.4.58.0404201404510.1296@pcl321.mppmu.mpg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, 20 Apr 2004, Jean Delvare wrote:

> Hi Peter,
>
> I think I would accept unified patches doing what you propose for
> lm_sensors and i2c.

Hi Jean,

here they are. Please feel free to adapt the wording to your taste.

regards
Peter Breitenlohner <peb@mppmu.mpg.de>
-------------- next part --------------
diff -ur i2c-2.8.4.orig/Makefile i2c-2.8.4/Makefile
--- i2c-2.8.4.orig/Makefile	2004-01-17 02:14:11.000000000 +0100
+++ i2c-2.8.4/Makefile	2004-04-21 10:56:28.000000000 +0200
@@ -187,12 +187,21 @@
 endif
 
 install :: all
+ifeq ($(DESTDIR),)
 	@echo "*** If the depmod command below generates errors, you should pay particular"
 	@echo "*** attention to the note #1 below."
-ifeq ($(DESTDIR),)
 	-/sbin/depmod -a
 else
-	-/sbin/depmod -a -b $(DESTDIR)
+	@echo "*** This is a \`staged' install using \"$(DESTDIR)\" as prefix."
+	@echo "***"
+	@echo "*** Once the modules have been moved to their final destination"
+	@echo "*** you must run the command \"/sbin/depmod -a\"."
+	@echo "***"
+	@echo "*** Alternatively, if you build a package (e.g. rpm), include the"
+	@echo "*** command \"/sbin/depmod -a\" in the post-(un)install procedure."
+	@echo "***"
+	@echo "*** If the depmod command mentioned above generates errors, you should"
+	@echo "*** pay particular attention to the note #1 below."
 endif
 	@echo "*** Installation successful!"
 	@echo "*** Important notes:"
@@ -201,7 +210,7 @@
 	@echo "***    version of i2c. Such drivers include commonly used video drivers"
 	@echo "***    such as bttv and zoran, and less commonly used ones such as"
 	@echo "***    i2c-matroxfb. If you really need these, then you shouldn't use our"
-	@echo "***    i2c package. If you can leave without them, you should make sure"
+	@echo "***    i2c package. If you can live without them, you should make sure"
 	@echo "***    such drivers do not exist on your system anymore. Loading them"
 	@echo "***    now would result in a severe system crash. We are working on the"
 	@echo "***    problem and will soon submit a complete i2c patch for inclusion in"
-------------- next part --------------
diff -ur lm_sensors-2.8.6.orig/Makefile lm_sensors-2.8.6/Makefile
--- lm_sensors-2.8.6.orig/Makefile	2004-02-06 19:23:17.000000000 +0100
+++ lm_sensors-2.8.6/Makefile	2004-04-21 10:39:05.000000000 +0200
@@ -259,12 +259,21 @@
 	@echo "***    to fit your needs again."
 all :: user
 install :: all user_install
+ifeq ($(DESTDIR),)
 	@echo "*** The depmod command below may generate errors. We are aware of the"
 	@echo "*** problem and are working on a solution."
-ifeq ($(DESTDIR),)
 	-/sbin/depmod -a
 else
-	-/sbin/depmod -a -b $(DESTDIR)
+	@echo "*** This is a \`staged' install using \"$(DESTDIR)\" as prefix."
+	@echo "***"
+	@echo "*** Once the modules have been moved to their final destination"
+	@echo "*** you must run the command \"/sbin/depmod -a\"."
+	@echo "***"
+	@echo "*** Alternatively, if you build a package (e.g. rpm), include the"
+	@echo "*** command \"/sbin/depmod -a\" in the post-(un)install procedure."
+	@echo "***"
+	@echo "*** The depmod command mentioned above may generate errors. We are"
+	@echo "*** aware of the problem and are working on a solution."
 endif
 
 clean::
