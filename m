From: jcromie@divsol.com (Jim Cromie)
Date: Sat, 23 Jul 2005 03:14:12 +0000
Subject: [lm-sensors] [patch]  KERNELVERSION=2.6.12-something make
Message-Id: <42E199CD.4070709@divsol.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <42E04664.3020001@divsol.com>
In-Reply-To: <42E04664.3020001@divsol.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jim Cromie wrote:

>
> So, patch attached, which adds a # comment, so that when clueful users
> look at the line in the makefile, they'll know why its an error.
> Also replaced leading spaces with tabs, to keep emacs makefile mode
> from interrogating me on saves (not needed for making, but saves 
> annoyance).
>
ahh, umm, here it is.  I hate it when I do that. which is too often.


-------------- next part --------------
--- lm_sensors2/Makefile.~1.96.~	2005-07-22 14:56:59.000000000 -0600
+++ lm_sensors2/Makefile	2005-07-22 15:09:16.000000000 -0600
@@ -86,6 +86,16 @@
 #   /lib/modules/2.4.29
 MODPREF := /lib/modules/$(shell $(CC) -I$(LINUX_HEADERS) -E etc/config.c | grep uts_release |cut -f 2 -d'"')
 
+# protect 2.6 users from misusing makefile, and getting confusing results
+ifeq (,$(findstring /2.4., $(MODPREF)))
+    ifeq (, $(MAKECMDGOALS))
+        $(error For 2.6 kernels and later, use "make user")
+    endif
+    ifeq (install, $(MAKECMDGOALS))
+        $(error For 2.6 kernels and later, use "make user_install")
+    endif
+endif
+
 # This is the directory where sensors.conf will be installed, if no other
 # configuration file is found
 ETCDIR := /etc
@@ -310,7 +320,7 @@
 	$(RM) lm_sensors-*
 
 user_uninstall::
-	
+
 uninstall :: user_uninstall
 	@echo "*** Note:"
 	@echo "***  * Kernel modules were not uninstalled."
@@ -409,7 +419,7 @@
 
 %.d: %.c $(LINUX)/.config
 	$(CC) -M -MG $(MODCPPFLAGS) $(MODCFLAGS) $< | \
-       	$(SED) -e 's@^\(.*\)\.o:@$*.d $*.o: Makefile '`dirname $*.d`/Module.mk' @' > $@
+	$(SED) -e 's@^\(.*\)\.o:@$*.d $*.o: Makefile '`dirname $*.d`/Module.mk' @' > $@
 
 
 
@@ -419,7 +429,7 @@
 
 %.rd: %.c
 	$(CC) -M -MG $(PROGCPPFLAGS) $(PROGCFLAGS) $< | \
-       	$(SED) -e 's@^\(.*\)\.o:@$*.rd $*.ro: Makefile '`dirname $*.rd`/Module.mk' @' > $@
+	$(SED) -e 's@^\(.*\)\.o:@$*.rd $*.ro: Makefile '`dirname $*.rd`/Module.mk' @' > $@
 
 
 %: %.ro
@@ -432,7 +442,7 @@
 
 %.ad: %.c
 	$(CC) -M -MG $(ARCPPFLAGS) $(ARCFLAGS) $< | \
-       	$(SED) -e 's@^\(.*\)\.o:@$*.ad $*.ao: Makefile '`dirname $*.ad`/Module.mk' @' > $@
+	$(SED) -e 's@^\(.*\)\.o:@$*.ad $*.ao: Makefile '`dirname $*.ad`/Module.mk' @' > $@
 
 
 # .lo files are used for shared libraries
@@ -441,7 +451,7 @@
 
 %.ld: %.c
 	$(CC) -M -MG $(LIBCPPFLAGS) $(LIBCFLAGS) $< | \
-       	$(SED) -e 's@^\(.*\)\.o:@$*.ld $*.lo: Makefile '`dirname $*.ld`/Module.mk' @' > $@
+	$(SED) -e 's@^\(.*\)\.o:@$*.ld $*.lo: Makefile '`dirname $*.ld`/Module.mk' @' > $@
 
 
 # Flex and Bison
