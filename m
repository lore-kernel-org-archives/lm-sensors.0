From: Didier Roche <didrocks@ubuntu.com>
Date: Mon, 27 Apr 2009 11:21:58 +0000
Subject: [lm-sensors] Please,
Message-Id: <fe6167c00904270421g19534018n7d544427e675d412@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi lm-sensors developer,

It would be great if lm-sensors can take into account distribution
LDFLAGS so that exported variables change linker behavior.

For instance, ubuntu uses -Wl,-Bsymbolic-functions. Taking this patch
will enable us to just sync from debian on this package.

In Ubuntu, we've applied the attached patch to achieve the following:

  * handle default ubuntu LDFLAGS for linking option (LP: #321632)
    - Remove the old hack directly pushed in lib/Module.mk (now
      lib/Module.mk if from pristine source)
    - add debian/patches/07-use-LDFLAGS.patch to take LDFLAGS into account

Debian and Ubuntu thought you might be interested to handle this
directly upstream.


--- lm-sensors-3-3.0.2.orig/lib/Module.mk      2008-05-18
8:07:48.000000000 +0200
+++ lm-sensors-3-3.0.2/lib/Module.mk   2009-01-26 22:15:02.000000000 +0100
@@ -60,7 +60,7 @@

 # How to create the shared library
 $(MODULE_DIR)/$(LIBSHLIBNAME): $(LIBSHOBJECTS)
-      $(CC) -shared -Wl,-soname,$(LIBSHSONAME) -o $@ $^ -lc -lm
+      $(CC) -shared $(LDFLAGS) -Wl,-soname,$(LIBSHSONAME) -o $@ $^ -lc -lm

 $(MODULE_DIR)/$(LIBSHSONAME): $(MODULE_DIR)/$(LIBSHLIBNAME)
       $(RM) $@


Thanks in advance. Please CC me as I'm not subscribed to the mailing list.
Didier

Ubuntu bug: https://bugs.edge.launchpad.net/debian/+source/lm-sensors-3/+bug/321632
Debian bug: http://bugs.debian.org/cgi-bin/bugreport.cgi?bugQ3171

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
