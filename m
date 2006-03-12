From: khali@linux-fr.org (Jean Delvare)
Date: Sun, 12 Mar 2006 15:47:01 +0000
Subject: [lm-sensors] i2c-2.10.0 and lm_sensors-2.10.0 --- 2 patches
Message-Id: <20060312164701.20355fc9.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <Pine.LNX.4.64.0603080940220.1369@pcl321.mppmu.mpg.de>
In-Reply-To: <Pine.LNX.4.64.0603080940220.1369@pcl321.mppmu.mpg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Peter,

> > --- Makefile	23 Feb 2006 22:58:52 -0000	1.103
> > +++ Makefile	11 Mar 2006 16:57:39 -0000
> > @@ -82,7 +82,8 @@
> > # This is the main modules directory into which the modules will be installed.
> > # The magic invocation will return something like this:
> > #   /lib/modules/2.4.29
> > -MODPREF := /lib/modules/$(shell $(CC) -I$(LINUX_HEADERS) -E etc/config.c | grep uts_release |cut -f 2 -d'"')
> > +KERNELVERSION = $(shell $(CC) -I$(LINUX_HEADERS) -E etc/config.c | grep uts_release |cut -f 2 -d'"')
> > +MODPREF := /lib/modules/$(KERNELVERSION)
> >
> > # When building userspace for use with 2.4.x series kernels, we turn off
> > # sysfs support by default.  You can override this (e.g. if you want
> > @@ -319,7 +320,7 @@
> > all :: user
> > install :: all user_install
> > ifeq ($(DESTDIR),)
> > -	-/sbin/depmod -a
> > +	-/sbin/depmod -a $(KERNELVERSION)
> > else
> > 	@echo "*** This is a \`staged' install using \"$(DESTDIR)\" as prefix."
> > 	@echo "***"
> >
> > What do you think? That way setting either LINUX or KERNELVERSION on
> > the command line will work.
> 
> Yes, but the above patch is still incomplete. I think one should use
> 
>  	-/sbin/depmod -a -F <location of System.map> $(KERNELVERSION)
> 
> where <location of System.map> could, e.g., be
> 
>  	$(MODPREF)/build/System.map

Ah yes, you're right. This leads me to the following patch, which I'll
apply if there are no more objections:

Index: Makefile
=================================RCS file: /home/cvs/lm_sensors2/Makefile,v
retrieving revision 1.103
diff -u -r1.103 Makefile
--- Makefile	23 Feb 2006 22:58:52 -0000	1.103
+++ Makefile	12 Mar 2006 16:37:58 -0000
@@ -82,7 +82,8 @@
 # This is the main modules directory into which the modules will be installed.
 # The magic invocation will return something like this:
 #   /lib/modules/2.4.29
-MODPREF := /lib/modules/$(shell $(CC) -I$(LINUX_HEADERS) -E etc/config.c | grep uts_release |cut -f 2 -d'"')
+KERNELVERSION = $(shell $(CC) -I$(LINUX_HEADERS) -E etc/config.c | grep uts_release |cut -f 2 -d'"')
+MODPREF := /lib/modules/$(KERNELVERSION)
 
 # When building userspace for use with 2.4.x series kernels, we turn off
 # sysfs support by default.  You can override this (e.g. if you want
@@ -319,7 +320,9 @@
 all :: user
 install :: all user_install
 ifeq ($(DESTDIR),)
-	-/sbin/depmod -a
+	-if [ -r $(MODPREF)/build/System.map -a -x /sbin/depmod ] ; then \
+	  /sbin/depmod -a -F $(MODPREF)/build/System.map $(KERNELVERSION) ; \
+	fi
 else
 	@echo "*** This is a \`staged' install using \"$(DESTDIR)\" as prefix."
 	@echo "***"

> With that I got no errors (on a 2.4.30 system when building lm_sensors for a
> 2.4.32 kernel), but I got lots of errors without the "-F".
> 
> > Note that I ended up with an error either way. I'm running a 2.6
> > kernel, and when building lm_sensors for a 2.4.32 kernel, depmod now
> > dies with the following error:
> >
> > /sbin/depmod -a 2.4.32
> > depmod: QM_MODULES: Function not implemented
> >
> > Any idea what's going on? I did not have the problem before "thanks" to
> > our broken Makefile (depmod was run for the 2.6 kernel instead). Now, no
> > big deal either, the error isn't fatal, but it makes me curious.
> 
> I think I know what's going on: With the 2.6 kernel you have depmod from
> module-init-tools. This works for 2.6 kernels but falls back to depmod.old
> (the renamed depmod from modutils) when running on a 2.4 system or when a
> version earlier than 2.5.48 is specified on the command line.
> 
> It seems, this somehow doesn't work as expected when running on a 2.6
> system.
> 
> One way out would be to test if /sbin/depmod.old exists and if so directly
> invoke depmod.old.

I had tried that already, but it didn't work. But it turns out that the
-F you suggested above fixes it :)

Thanks,
-- 
Jean Delvare

