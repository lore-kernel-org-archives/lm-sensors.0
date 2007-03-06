From: khali@linux-fr.org (Jean Delvare)
Date: Tue, 06 Mar 2007 17:47:40 +0000
Subject: [lm-sensors] [PATCH] Thread-safe libsensors
Message-Id: <20070306184740.7ade7332.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi all,

I noticed that the Suse sensors package is compiled with the following
change (amongst many others):

Index: Makefile
=================================--- Makefile	(revision 4317)
+++ Makefile	(working copy)
@@ -279,7 +279,7 @@
 ifdef SYSFS_SUPPORT
 LIBCPPFLAGS := $(LIBCPPFLAGS) -DSYSFS_SUPPORT
 endif
-LIBCFLAGS := -fpic $(ALL_CFLAGS)
+LIBCFLAGS := -fpic -D_REENTRANT $(ALL_CFLAGS)
 
 .PHONY: all user clean install user_install uninstall user_uninstall version package
 

I seem to understand that it is required for libsensors to be
thread-safe, which would be a nice feature if any multithreaded
application ever wants to link with it. So I think I'll apply this
patch to our repository before releasing lm_sensors 2.10.3. Comment
anyone?

-- 
Jean Delvare

