From: quintela@mandrakesoft.com (Juan Quintela)
Date: Thu, 19 May 2005 06:23:37 +0000
Subject: [PATCH]: sensord  man page should belong to section 8
Message-Id: <m28z3m3dq7.fsf@demo.mitica>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi
        what do you think about this change?  All the other system
        daemons man pages are in the section 8, section 1 is for user
        programs.

Later, Juan.

diff -up lm_sensors-2.6.4/prog/sensord/Module.mk.orig lm_sensors-2.6.4/prog/sensord/Module.mk
--- lm_sensors-2.6.4/prog/sensord/Module.mk.orig	2002-08-04 16:17:47.000000000 +0200
+++ lm_sensors-2.6.4/prog/sensord/Module.mk	2002-08-04 16:20:06.000000000 +0200
@@ -25,8 +25,8 @@
 MODULE_DIR := prog/sensord
 PROGSENSORDDIR := $(MODULE_DIR)
 
-PROGSENSORDMAN1DIR := $(MANDIR)/man8
-PROGSENSORDMAN1FILES := $(MODULE_DIR)/sensord.8
+PROGSENSORDMAN8DIR := $(MANDIR)/man8
+PROGSENSORDMAN8FILES := $(MODULE_DIR)/sensord.8
 
 # Regrettably, even 'simply expanded variables' will not put their currently
 # defined value verbatim into the command-list of rules...
@@ -46,7 +46,7 @@ all :: all-prog-sensord
 install-prog-sensord: all-prog-sensord
 	$(MKDIR) $(DESTDIR)$(SBINDIR) $(DESTDIR)$(PROGSENSORDMAN1DIR)
 	$(INSTALL) -m 755 $(PROGSENSORDTARGETS) $(DESTDIR)$(SBINDIR)
-	$(INSTALL) -m 644 $(PROGSENSORDMAN1FILES) $(DESTDIR)$(PROGSENSORDMAN1DIR)
+	$(INSTALL) -m 644 $(PROGSENSORDMAN8FILES) $(DESTDIR)$(PROGSENSORDMAN8DIR)
 install :: install-prog-sensord
 
 clean-prog-sensord:


-- 
In theory, practice and theory are the same, but in practice they 
are different -- Larry McVoy
