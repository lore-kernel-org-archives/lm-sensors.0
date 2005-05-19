From: ppokorny@penguincomputing.com (Philip Pokorny)
Date: Thu, 19 May 2005 06:24:03 +0000
Subject: Port of lk2-4 branch to HEAD in CVS
Message-Id: <3F065ED3.6000307@penguincomputing.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

The following patch should migrate the changes from the current lk2-4 branc=
h=20
over to the HEAD.

If you checkout the head, then apply this patch and then checkin the result=
s,=20
it should effect a merge of the lk2-4 branch to the main line.

You may have to apply the patch using -p2 or -p3 since there are several=20
parent directories in the diff command lines.

:v)
-------------- next part --------------
diff -ru -N -x CVS lm_sensors-cvs/i2c/CHANGES lm_sensors-lk2-4/i2c/CHANGES
--- lm_sensors-cvs/i2c/CHANGES	Fri May 30 17:13:42 2003
+++ lm_sensors-lk2-4/i2c/CHANGES	Thu Jul  3 15:50:47 2003
@@ -18,14 +18,45 @@
 --------------------------------------------------------------------------=
---
=20
 2.8.0 (2003????)
+  Interface changes:
+	- File i2c-dev.h: remove all userspace code, moved to
+                          i2c-dev.h in lm_sensors2 package
+	- Struct i2c_adapter: remove inc_use() and dec_use(), add owner,
+                              remove client_count, replace semaphore lock
+                              with semaphores bus and list.
+	- Struct i2c_algorithm: add owner
+	- Struct i2c_driver: remove inc_use() and dec_use()
+	- Struct i2c_msg: type changes; add err and done
+	- Struct i2c_smbus_ioctl_data, i2c_rdwr_ioctl_data: type changes
+	- Remove controlling_mod argument in i2c_register_entry()
+	- Remove i2c_inc_use_client() and i2c_dec_use_client()
+	- Add i2c_client_command()
+  Makefiles: Handle multiple UTS_RELEASE definitions in linux/version.h;
+             Remove old gzipped modules; remove old misc directory if empt=
y;
+             Don't use /usr/include headers for modules;
+             Remove pre-2.4 installation method;
+             Run depmod after module installation
+  Modules (all): Cleanups including
+	- C99 initializers
+	- Remove #ifdef MODULE
+	- Remove #ifndef THIS_MODULE
+	- Remove #ifndef MODULE_LICENSE
+	- Remove init_MUTEX #define
+	- Remove EXPORT_NO_SYMBOLS
+	- Remove dummy xxx_command() definitions
+	- Use module_init() and module_exit()
   drivers (several): make spinlock_t's static
-  i2c-algo-biths.[ch]: Rewrite of i2c-algo-bit with improved bus timing and
-           error handling. This is not a drop-in replacement for i2c-algo-=
bit.
-           Interface subject to change.
+  i2c-algo-biths.[ch]: (new) Rewrite of i2c-algo-bit with improved
+                       bus timing and error handling.
+                       This is not a drop-in replacement for i2c-algo-bit.
+                       Interface subject to change.
+  i2c-core.c: Rewrite locking;
+              Remove initialization of other modules in i2c_init_all()
+  i2c-dev.c: Fixes from kernel 2.4.21-rc7
   i2c-id.h: add IDs for i2c-algo-biths, W83627HF, LM85, nForce2, OMAHA, GU=
IDE,
             MPC107, IXP2000, IXP425, IOP3XX, UDA1342, S3VIA
   i2c-proc.c: Fix ignore and probe tests
-  i2c.h: Add fields for detailed delivery report in i2c_msg.
+  mkpatch: Remove patching of drivers/char/mem.c
=20
 2.7.0 (20021208)
   drivers (several): C99 initializers (sync w/ kernel 2.5.49); HZ fixes
diff -ru -N -x CVS lm_sensors-cvs/i2c/INSTALL lm_sensors-lk2-4/i2c/INSTALL
--- lm_sensors-cvs/i2c/INSTALL	Thu Nov 14 05:23:07 2002
+++ lm_sensors-lk2-4/i2c/INSTALL	Fri Jul  4 20:14:10 2003
@@ -1,18 +1,22 @@
 These are the installation instructions for the i2c package.
+This package is ONLY for 2.4 kernels 2.4.9 or later !!!
=20
-There are three ways in which you can compile and install this package. Ea=
ch
-has its own strong points. They are:
+There are three ways in which you can compile and install this package.
+Option 1 is much easier and is recommended.
=20
  1. Complete separate from kernel compilation
+    (only for 2.4 kernels 2.4.9 or later)
     This will generate a set of modules which can be inserted and removed
-    as needed; nothing will be written into the kernel tree;
+    as needed; nothing will be written into the kernel tree.
=20
  2. Semi-integrated into the kernel=20
+    (only for 2.4 kernels 2.4.9 or later)
     This will add some files to your kernel tree, but has the advantage
     that module symbols are supported; the end result is functionally very=
=20
     like the previous way;
=20
  3. Patching of the kernel
+    (only for 2.4 kernels 2.4.13 or later)
     This will patch your kernel source tree. You must recompile your kernel
     to take advantage of this. But it makes it possible to compile drivers
     into the kernel itself, instead of having to add them as modules.
@@ -21,8 +25,11 @@
 We recommend using either method 1 or 3;
 method 2 is less well maintained.
=20
-NOTE: SUPPORT FOR 2.0 AND 2.1 KERNELS HAS BEEN DROPPED!
-NOTE: METHOD 3 ONLY WORKS FOR 2.2 KERNELS AND 2.4 KERNELS (2.4.0 OR LATER)
+NOTE: SUPPORT FOR KERNELS 2.0.0 - 2.4.8 HAS BEEN DROPPED!
+      2.4.9 OR LATER REQUIRED!
+
+FOR 2.5 KERNELS, Do not attempt to compile this package.
+                 Use the drivers already in the 2.5 kernel development tre=
e.
=20
=20
 Having a proper kernel tree (compilation options 1 and 2)
@@ -167,7 +174,7 @@
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=20
 There is a special script which should be able to generate diffs against
-any 2.2 and 2.4 kernel (2.4.0 and later). Note that 2.3 kernels are no=20
+any 2.4 kernel (2.4.13 and later). Note that older kernels are no=20
 longer supported.
 Please report any problems to our mailinglist. Note that it may fail,=20
 and probably silently, if you have applied other patches to your kernel=20
diff -ru -N -x CVS lm_sensors-cvs/i2c/Makefile lm_sensors-lk2-4/i2c/Makefile
--- lm_sensors-cvs/i2c/Makefile	Sun Jan 12 04:15:00 2003
+++ lm_sensors-lk2-4/i2c/Makefile	Thu Jul  3 15:50:47 2003
@@ -59,8 +59,9 @@
 # The magic invocation will return something like this:
 #   /lib/modules/2.2.15-ac9/misc
 #MODDIR :=3D /lib/modules/`grep UTS_RELEASE $(LINUX_HEADERS)/linux/version=
.h|cut -f 2 -d'"'`/misc
-MODPREF :=3D /lib/modules/`grep UTS_RELEASE $(LINUX_HEADERS)/linux/version=
.h|cut -f 2 -d'"'`
+#MODPREF :=3D /lib/modules/`grep UTS_RELEASE $(LINUX_HEADERS)/linux/versio=
n.h|cut -f 2 -d'"'`
 #MODPREF :=3D /lib/modules/$(KERNELVERSION)
+MODPREF :=3D /lib/modules/$(shell $(CC) -I$(LINUX_HEADERS) -E etc/config.c=
 | grep uts_release |cut -f 2 -d'"')
=20
 # This is the directory into which the header files will be installed.
 # If you want to make sure your current kernel tree is not overwritten,
@@ -104,6 +105,7 @@
=20
 # Some often-used commands with default options
 MKDIR :=3D mkdir -p
+RMDIR :=3D rmdir
 RM :=3D rm -f
 CC :=3D gcc
 BISON :=3D bison
@@ -116,10 +118,11 @@
 # Determine the default compiler flags
 # MODCFLAGS is to create in-kernel object files (modules)
=20
-CFLAGS :=3D -I$(LINUX_HEADERS) -O2 -DLM_SENSORS
+CPPFLAGS :=3D -I$(LINUX_HEADERS)
+CFLAGS :=3D -Wall -O2 -DLM_SENSORS
=20
 ifeq ($(WARN),1)
-CFLAGS +=3D -Wall -Wstrict-prototypes -Wshadow -Wpointer-arith -Wcast-qual=
 \
+CFLAGS +=3D -W -Wstrict-prototypes -Wshadow -Wpointer-arith -Wcast-qual \
           -Wcast-align -Wwrite-strings -Wnested-externs -Winline
 endif
=20
@@ -138,13 +141,19 @@
 endif
=20
 ifeq ($(SMP),1)
-MODCFLAGS +=3D -D__SMP__
+MODCPPFLAGS +=3D -D__SMP__
 endif
=20
 ifeq ($(MODVER),1)
-MODCFLAGS +=3D -DMODVERSIONS -include $(LINUX_HEADERS)/linux/modversions.h
+MODCPPFLAGS +=3D -DMODVERSIONS -include $(LINUX_HEADERS)/linux/modversions=
.h
 endif
=20
+# This magic is from the kernel Makefile.
+# Extra cflags for kbuild 2.4.  The default is to forbid includes by kerne=
l code
+# from user space headers.
+kbuild_2_4_nostdinc :=3D -nostdinc $(shell LC_ALL=3DC $(CC) -print-search-=
dirs | sed -ne 's/install: \(.*\)/-I \1include/gp')
+MODCPPFLAGS +=3D $(CPPFLAGS) $(kbuild_2_4_nostdinc)
+
 .PHONY: dep
 # Make all the default rule
 all::
@@ -166,6 +175,11 @@
 all ::
=20
 install :: all
+ifeq ($(DESTDIR),)
+	-/sbin/depmod -a
+else
+	-/sbin/depmod -a -b $(DESTDIR)
+endif
=20
 clean::
 	$(RM) lm_sensors-*
@@ -179,9 +193,9 @@
=20
 # .o files are used for modules
 %.o: %.c
-	$(CC) $(MODCFLAGS) -c $< -o $@
+	$(CC) $(MODCPPFLAGS) $(MODCFLAGS) -c $< -o $@
=20
 %.d: %.c
-	$(CC) -M -MG $(MODCFLAGS) $< | \
+	$(CC) -M -MG $(MODCPPFLAGS) $(MODCFLAGS) $< | \
 	sed -e 's@^\(.*\)\.o:@$*.d $*.o: Makefile '`dirname $*.d`/Module.mk' @' >=
 $@
=20
diff -ru -N -x CVS lm_sensors-cvs/i2c/QUICKSTART lm_sensors-lk2-4/i2c/QUICK=
START
--- lm_sensors-cvs/i2c/QUICKSTART	Sun Jul  9 13:35:42 2000
+++ lm_sensors-lk2-4/i2c/QUICKSTART	Fri Jul  4 20:14:10 2003
@@ -2,13 +2,30 @@
 The instructions in this document will only work if you have a standard
 system, and may cause problems.
=20
-Quickstart:
+Quickstart for compiling outside the kernel.
+This is by far the EASIEST METHOD.
+Other methods are described in INSTALL.
+------------------------------------------
+
+  * Verify you are running a 2.4 kernel, 2.4.9 or later.
+
   * Make sure you have the kernel tree corresponding to your current
-    kernel in /usr/src/linux. Distribution kernels usually won't do,
-    compile your own from a 'vanilla' tree (get one from
-    ftp://ftp.kernel/org/pub/linux/kernel/).
+    kernel in /lib/modules/(uname -r)/build.
+    Even if the source is there, it may not correspond to your running
+    kernel. If so, you will have to recompile your kernel.
+
+  * Do `lsmod'. If there are any old i2c or sensors modules loaded,
+    you MUST remove them (as root) with `rmmod'.
+
+  * Verify that your i2c support in the kernel is configured as
+    modules or is disabled. If it is compiled-in, you obviously
+    cannot replace it with modules in the next step.
+
   * Do a `make' followed by a `make install'. The warnings about .d
     files at the start are harmless.
+
   * Make sure you do a `depmod -a'.
+
   * That's all (but you need client drivers from some other source to do=20
-    anything interesting)
+    anything interesting - see the lm_sensors page:
+    http://secure.netroedge.com/~lm78/
diff -ru -N -x CVS lm_sensors-cvs/i2c/README lm_sensors-lk2-4/i2c/README
--- lm_sensors-cvs/i2c/README	Sat Jun 30 11:59:37 2001
+++ lm_sensors-lk2-4/i2c/README	Fri Jul  4 20:14:10 2003
@@ -1,8 +1,15 @@
-These are the updated i2c drivers, also known as the `Simon Vogl' drivers.
+These package includes the basic i2c drivers.
+This package is ONLY for 2.4 kernels 2.4.9 or later !!!
=20
-Updated means: more updated than the ones found in the current kernels.
+ADDITIONALLY, i2c-2.8.0 is not API compatible to earlier i2c
+releases due to struct changes; therefore you must NOT ENABLE
+any other i2c drivers (e.g. bttv) in the 2.4 kernel.
+Do NOT use lm-sensors 2.8.0 or i2c-2.8.0 if you require bttv.
=20
-If you have used this package before, please read IMPORTANT_CHANGES!
+FOR 2.5 KERNELS, Do not attempt to compile this package.
+                 Use the drivers already in the 2.5 kernel development tre=
e.
+
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=20
 There are basically two kinds of i2c drivers: drivers for busses and drive=
rs
 for chips. Both are cut in two, to isolate common parts: bus drivers are
@@ -20,4 +27,4 @@
 See doc/summary for a description of the drivers in this package.
=20
 You can reach the developers of this package at their mailing list, at
-linux-i2c@pelican.tk.uni-linz.ac.at.
+sensors@stimpy.netroedge.com.
diff -ru -N -x CVS lm_sensors-cvs/i2c/TODO lm_sensors-lk2-4/i2c/TODO
--- lm_sensors-cvs/i2c/TODO	Sun Jul  7 17:56:17 2002
+++ lm_sensors-lk2-4/i2c/TODO	Fri Jul  4 20:14:10 2003
@@ -2,17 +2,18 @@
 Contact us if you have comments or wish to help.
 ------------------------------------------------
=20
-* Send 2.6.3 patch to Marcelo (2.6.1 in kernel 2.4.13)
+* Send 2.8.0 patch to Marcelo (2.6.1 in kernel 2.4.13)
=20
-* Send 2.6.4 patch to Linus (2.6.3 in kernel 2.5.24)
-
-* SMBus 2.0
+* SMBus 2.0 Completion
   SMBus 2.0 adds PEC, ARP, and a block process call message.
-  All is complete in release 2.6.4 except:
+  All is complete in release 2.6.4 except for:
 	- SW PEC for Word Data and Process Call. No place to put PEC
 	  in the current i2c_smbus_data structure.
+  For a summary of SMBus protocol support, see
+	http://www2.lm-sensors.nu/~lm78/protocol.html
=20
 * Timing considerations in SMBus emulation with i2c-algo-bit (D.E.):
+  (Note that some of these changes are implemented in i2c-algo-biths)
   The Smbus defines a minimum frequency of 10 KHZ for driving the bus, whi=
le
   the I2C does not define any minimum frequency.
   furthermore the maximum time a master is allowed to keep the CLK line hi=
gh
diff -ru -N -x CVS lm_sensors-cvs/i2c/etc/config.c lm_sensors-lk2-4/i2c/etc=
/config.c
--- lm_sensors-cvs/i2c/etc/config.c	Wed Dec 31 16:00:00 1969
+++ lm_sensors-lk2-4/i2c/etc/config.c	Mon Jun  2 17:20:46 2003
@@ -0,0 +1,8 @@
+/*
+ * This is used by the top-level makefile to automagically
+ * get the kernel version from <linux/version.h>.
+ * A simple grep doesn't work for Mandrake and Red Hat distributions
+ * that contain multiple UTS_RELEASE definitions in version.h.
+ */
+#include <linux/version.h>
+char *uts_release=3DUTS_RELEASE;
diff -ru -N -x CVS lm_sensors-cvs/i2c/kernel/Module.mk lm_sensors-lk2-4/i2c=
/kernel/Module.mk
--- lm_sensors-cvs/i2c/kernel/Module.mk	Fri May 30 07:46:39 2003
+++ lm_sensors-lk2-4/i2c/kernel/Module.mk	Mon Jun 16 18:59:35 2003
@@ -70,9 +70,6 @@
 ifneq ($(shell if grep -q '^CONFIG_I2C_PPORT=3Dy' $(LINUX)/.config; then e=
cho 1; fi),1)
 KERNELTARGETS +=3D $(MODULE_DIR)/i2c-pport.o
 endif
-ifeq ($(shell if grep -q '^CONFIG_I2C_IOP3XX=3Dy' $(LINUX)/.config; then e=
cho 1; fi),1)
-KERNELTARGETS +=3D $(MODULE_DIR)/i2c-iop3xx.o
-endif
 #
 # No CONFIG option for this yet (not in mkpatch)
 #
@@ -94,7 +91,6 @@
=20
 all-kernel: $(KERNELTARGETS)
 all :: all-kernel
-	echo KERNELTARGETS $(KERNELTARGETS)
=20
 #
 # If $MODPREF/kernel exists, we presume the new (2.4.0) /lib/modules/x.y.z=
 directory
@@ -103,16 +99,12 @@
 #
 install-kernel: all-kernel
 	if [ -n "$(KERNELTARGETS)" ] ; then \
-	  if [ -d "$(DESTDIR)$(MODPREF)/kernel" ] ; then \
-	    $(MKDIR) $(DESTDIR)$(MODPREF)/kernel/drivers/i2c ; \
-	    $(INSTALL) -o root -g root -m 644 $(KERNELTARGETS) $(DESTDIR)$(MODPRE=
F)/kernel/drivers/i2c ; \
-	    for i in $(KERNELTARGETS) ; do \
-	      $(RM) $(DESTDIR)$(MODPREF)/misc/`basename $$i` ; \
-	    done \
-	  else \
-	    $(MKDIR) $(DESTDIR)$(MODPREF)/misc ; \
-	    $(INSTALL) -o root -g root -m 644 $(KERNELTARGETS) $(DESTDIR)$(MODPRE=
F)/misc ; \
-	  fi \
+	  $(MKDIR) $(DESTDIR)$(MODPREF)/kernel/drivers/i2c ; \
+	  $(INSTALL) -o root -g root -m 644 $(KERNELTARGETS) $(DESTDIR)$(MODPREF)=
/kernel/drivers/i2c ; \
+	  for i in $(KERNELTARGETS) ; do \
+	    $(RM) $(DESTDIR)$(MODPREF)/misc/`basename $$i` $(DESTDIR)$(MODPREF)/k=
ernel/drivers/i2c/`basename $$i`.gz ; \
+	  done ; \
+	  $(RMDIR) $(DESTDIR)$(MODPREF)/misc 2> /dev/null || true ; \
 	fi
 	if [ -n "$(KERNELINCLUDES)" ] ; then \
 	  $(MKDIR) $(DESTDIR)$(LINUX_INCLUDE_DIR) ; \
diff -ru -N -x CVS lm_sensors-cvs/i2c/kernel/i2c-algo-bit.c lm_sensors-lk2-=
4/i2c/kernel/i2c-algo-bit.c
--- lm_sensors-cvs/i2c/kernel/i2c-algo-bit.c	Tue Jan 21 00:08:16 2003
+++ lm_sensors-lk2-4/i2c/kernel/i2c-algo-bit.c	Mon Jun 16 18:59:35 2003
@@ -98,7 +98,12 @@
 		if (time_after_eq(jiffies, start+adap->timeout)) {
 			return -ETIMEDOUT;
 		}
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2,5,0)
+		if (current->need_resched)
+			schedule();
+#else
 		cond_resched();
+#endif
 	}
 	DEBSTAT(printk(KERN_DEBUG "needed %ld jiffies\n", jiffies-start));
 	udelay(adap->udelay);
@@ -503,7 +508,7 @@
 	return num;
 }
=20
-static u32 bit_func(struct i2c_adapter *adap)
+static u32 bit_func(struct i2c_adapter *i2c_adap)
 {
 	return I2C_FUNC_SMBUS_EMUL | I2C_FUNC_10BIT_ADDR |=20
 	       I2C_FUNC_PROTOCOL_MANGLING;
@@ -525,7 +530,6 @@
  */
 int i2c_bit_add_bus(struct i2c_adapter *adap)
 {
-	int i;
 	struct i2c_algo_bit_data *bit_adap =3D adap->algo_data;
=20
 	if (bit_test) {
diff -ru -N -x CVS lm_sensors-cvs/i2c/kernel/i2c-algo-biths.c lm_sensors-lk=
2-4/i2c/kernel/i2c-algo-biths.c
--- lm_sensors-cvs/i2c/kernel/i2c-algo-biths.c	Tue Jan 21 00:08:16 2003
+++ lm_sensors-lk2-4/i2c/kernel/i2c-algo-biths.c	Tue Jun 10 18:55:26 2003
@@ -166,7 +166,14 @@
 				adap->errors |=3D _HS_TIMEOUT; /* scl undef */
 				return;
 			}
+#ifdef cond_resched
 			cond_resched();
+#else
+			if (current->need_resched) {
+				set_current_state(TASK_UNINTERRUPTIBLE);
+				schedule_timeout(1);
+			}
+#endif
 		}
 		adap->set_timer(adap);
 		/* test for SDA arbitration when SCL is high */
diff -ru -N -x CVS lm_sensors-cvs/i2c/kernel/i2c-algo-pcf.c lm_sensors-lk2-=
4/i2c/kernel/i2c-algo-pcf.c
--- lm_sensors-cvs/i2c/kernel/i2c-algo-pcf.c	Tue Jan 21 00:08:16 2003
+++ lm_sensors-lk2-4/i2c/kernel/i2c-algo-pcf.c	Mon Jun 16 18:59:35 2003
@@ -442,7 +442,7 @@
  */
 int i2c_pcf_add_bus(struct i2c_adapter *adap)
 {
-	int i, status;
+	int i;
 	struct i2c_algo_pcf_data *pcf_adap =3D adap->algo_data;
=20
 	DEB2(printk(KERN_DEBUG "i2c-algo-pcf.o: hw routines for %s registered.\n",
diff -ru -N -x CVS lm_sensors-cvs/i2c/kernel/i2c-core.c lm_sensors-lk2-4/i2=
c/kernel/i2c-core.c
--- lm_sensors-cvs/i2c/kernel/i2c-core.c	Tue Jan 21 21:25:08 2003
+++ lm_sensors-lk2-4/i2c/kernel/i2c-core.c	Thu Jul  3 15:50:47 2003
@@ -297,14 +297,24 @@
 	return res;
 }
=20
-int i2c_check_addr (struct i2c_adapter *adapter, int addr)
+static int __i2c_check_addr (struct i2c_adapter *adapter, int addr)
 {
 	int i;
-	down(&adapter->list);
 	for (i =3D 0; i < I2C_CLIENT_MAX ; i++)=20
 		if (adapter->clients[i] && (adapter->clients[i]->addr =3D addr))
 			return -EBUSY;
+
+	return 0;
+}
+
+int i2c_check_addr (struct i2c_adapter *adapter, int addr)
+{
+	int rval;
+
+	down(&adapter->list);
+	rval =3D __i2c_check_addr(adapter, addr);
 	up(&adapter->list);
+
 	return 0;
 }
=20
@@ -379,23 +389,20 @@
 	return 0;
 }
=20
-static int i2c_inc_use_client(struct i2c_client *client)
+static void i2c_inc_use_client(struct i2c_client *client)
 {
-
-	if (!try_module_get(client->driver->owner))
-		return -ENODEV;
-	if (!try_module_get(client->adapter->owner)) {
-		module_put(client->driver->owner);
-		return -ENODEV;
-	}
-
-	return 0;
+	if(client->driver->owner)
+		__MOD_INC_USE_COUNT(client->driver->owner);
+	if(client->adapter->owner)
+		__MOD_INC_USE_COUNT(client->adapter->owner);
 }
=20
 static void i2c_dec_use_client(struct i2c_client *client)
 {
-	module_put(client->driver->owner);
-	module_put(client->adapter->owner);
+	if(client->driver->owner)
+		__MOD_DEC_USE_COUNT(client->driver->owner);
+	if(client->adapter->owner)
+		__MOD_DEC_USE_COUNT(client->adapter->owner);
 }
=20
 #if 0 /* just forget about this for now --km */
@@ -469,22 +476,18 @@
=20
 int i2c_use_client(struct i2c_client *client)
 {
-	if (!i2c_inc_use_client(client))
-		return -ENODEV;
-
 	if (client->flags & I2C_CLIENT_ALLOW_USE) {
 		if (client->flags & I2C_CLIENT_ALLOW_MULTIPLE_USE)
 			client->usage_count++;
 		else if (client->usage_count > 0)=20
-			goto busy;
+			return -EBUSY;
 		else=20
 			client->usage_count++;
 	}
=20
+	i2c_inc_use_client(client);
+
 	return 0;
- busy:
-	i2c_dec_use_client(client);
-	return -EBUSY;
 }
=20
 int i2c_release_client(struct i2c_client *client)
@@ -1411,6 +1414,13 @@
 #endif
 }
=20
+/* leave this in for now simply to make patching easier so we don't have
+   to remove the call in drivers/char/mem.c */
+int __init i2c_init_all(void)
+{
+	return 0;
+}
+
 EXPORT_SYMBOL(i2c_add_adapter);
 EXPORT_SYMBOL(i2c_del_adapter);
 EXPORT_SYMBOL(i2c_add_driver);
diff -ru -N -x CVS lm_sensors-cvs/i2c/kernel/i2c-dev.c lm_sensors-lk2-4/i2c=
/kernel/i2c-dev.c
--- lm_sensors-cvs/i2c/kernel/i2c-dev.c	Tue Jan 21 00:08:16 2003
+++ lm_sensors-lk2-4/i2c/kernel/i2c-dev.c	Thu Jul  3 15:50:47 2003
@@ -28,14 +28,16 @@
 /* The devfs code is contributed by Philipp Matthias Hahn=20
    <pmhahn@titan.lahn.de> */
=20
 /* $Id: i2c-dev.c,v 1.53 2003/01/21 08:08:16 kmalkki Exp $ */
=20
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/fs.h>
 #include <linux/slab.h>
 #include <linux/smp_lock.h>
+#ifdef CONFIG_DEVFS_FS
 #include <linux/devfs_fs_kernel.h>
+#endif
 #include <linux/init.h>
 #include "i2c.h"
 #include "i2c-dev.h"
@@ -75,6 +77,10 @@
=20
 #define I2CDEV_ADAPS_MAX I2C_ADAP_MAX
 static struct i2c_adapter *i2cdev_adaps[I2CDEV_ADAPS_MAX];
+#ifdef CONFIG_DEVFS_FS
+static devfs_handle_t devfs_i2c[I2CDEV_ADAPS_MAX];
+static devfs_handle_t devfs_handle =3D NULL;
+#endif
=20
 static struct i2c_driver i2cdev_driver =3D {
 	.owner		=3D THIS_MODULE, /* not really used */
@@ -206,6 +212,11 @@
 				   sizeof(rdwr_arg)))
 			return -EFAULT;
=20
+		/* Put an arbritrary limit on the number of messages that can
+		 * be sent at once */
+		if (rdwr_arg.nmsgs > 42)
+			return -EINVAL;
+              =20
 		rdwr_pa =3D (struct i2c_msg *)
 			kmalloc(rdwr_arg.nmsgs * sizeof(struct i2c_msg),=20
 			GFP_KERNEL);
@@ -222,6 +233,11 @@
 			        res =3D -EFAULT;
 				break;
 			}
+			/* Limit the size of the message to a sane amount */
+			if (rdwr_pa[i].len > 8192) {
+				res =3D -EINVAL;
+				break;
+			}
 			rdwr_pa[i].buf =3D kmalloc(rdwr_pa[i].len, GFP_KERNEL);
 			if(rdwr_pa[i].buf =3D NULL)
 			{
@@ -232,11 +248,17 @@
 				rdwr_arg.msgs[i].buf,
 				rdwr_pa[i].len))
 			{
-			    	kfree(rdwr_pa[i].buf);
 			    	res =3D -EFAULT;
 				break;
 			}
 		}
+		if (res < 0) {
+			int j;
+			for (j =3D 0; j < i; ++j)
+				kfree(rdwr_pa[j].buf);
+			kfree(rdwr_pa);
+			return res;
+		}
 		if (!res)=20
 		{
 			res =3D i2c_transfer(client->adapter,
@@ -361,14 +383,11 @@
 	memcpy(client,&i2cdev_client_template,sizeof(struct i2c_client));
=20
 	/* registered with adapter, passed as client to user */
-	client->adapter =3D file->private_data;
+	client->adapter =3D i2cdev_adaps[minor];
 	file->private_data =3D client;
=20
-	/* use adapter module, i2c-dev handled with fops */
-	if (!try_module_get(client->adapter->owner)) {
-		kfree(client);
-		return -ENODEV;
-	}
+	if(client->adapter->owner)
+		__MOD_INC_USE_COUNT(client->adapter->owner);
=20
 #ifdef DEBUG
 	printk(KERN_DEBUG "i2c-dev.o: opened i2c-%d\n",minor);
@@ -385,7 +404,8 @@
=20
 	client =3D file->private_data;
 	file->private_data =3D NULL;
-	module_put(client->adapter->owner);
+	if(client->adapter->owner)
+		__MOD_DEC_USE_COUNT(client->adapter->owner);
 	kfree(client);
 #ifdef DEBUG
 	printk(KERN_DEBUG "i2c-dev.o: Closed: i2c-%d\n", minor);
@@ -396,7 +416,7 @@
 int i2cdev_attach_adapter(struct i2c_adapter *adap)
 {
 	int i;
-	char name[12];
+	char name[8];
=20
 	if ((i =3D i2c_adapter_id(adap)) < 0) {
 		printk(KERN_DEBUG "i2c-dev.o: Unknown adapter ?!?\n");
@@ -407,17 +427,21 @@
 		return -ENODEV;
 	}
=20
-	sprintf (name, "i2c/%d", i);
+	sprintf (name, "%d", i);
 	if (! i2cdev_adaps[i]) {
 		i2cdev_adaps[i] =3D adap;
-		devfs_register (NULL, name,
+#ifdef CONFIG_DEVFS_FS
+		devfs_i2c[i] =3D devfs_register (devfs_handle, name,
 			DEVFS_FL_DEFAULT, I2C_MAJOR, i,
 			S_IFCHR | S_IRUSR | S_IWUSR,
 			&i2cdev_fops, adap);
+#endif
 		printk(KERN_DEBUG "i2c-dev.o: Registered '%s' as minor %d\n",adap->name,=
i);
 	} else {
 		/* This is actually a detach_adapter call! */
-		devfs_remove("i2c/%d", i);
+#ifdef CONFIG_DEVFS_FS
+		devfs_unregister(devfs_i2c[i]);
+#endif
 		i2cdev_adaps[i] =3D NULL;
 #ifdef DEBUG
 		printk(KERN_DEBUG "i2c-dev.o: Adapter unregistered: %s\n",adap->name);
@@ -444,15 +468,23 @@
=20
 	printk(KERN_INFO "i2c-dev.o: i2c /dev entries driver module version %s (%=
s)\n", I2C_VERSION, I2C_DATE);
=20
+#ifdef CONFIG_DEVFS_FS
+	if (devfs_register_chrdev(I2C_MAJOR, "i2c", &i2cdev_fops)) {
+#else
 	if (register_chrdev(I2C_MAJOR,"i2c",&i2cdev_fops)) {
+#endif
 		printk(KERN_ERR "i2c-dev.o: unable to get major %d for i2c bus\n",
 		       I2C_MAJOR);
 		return -EIO;
 	}
-	devfs_mk_dir(NULL, "i2c", NULL);
+#ifdef CONFIG_DEVFS_FS
+	devfs_handle =3D devfs_mk_dir(NULL, "i2c", NULL);
+#endif
 	if ((res =3D i2c_add_driver(&i2cdev_driver))) {
 		printk(KERN_ERR "i2c-dev.o: Driver registration failed, module not inser=
ted.\n");
-		devfs_remove("i2c");
+#ifdef CONFIG_DEVFS_FS
+		devfs_unregister(devfs_handle);
+#endif
 		unregister_chrdev(I2C_MAJOR,"i2c");
 		return res;
 	}
@@ -462,7 +494,9 @@
 static void __exit i2c_dev_exit(void)
 {
 	i2c_del_driver(&i2cdev_driver);
-	devfs_remove("i2c");
+#ifdef CONFIG_DEVFS_FS
+	devfs_unregister(devfs_handle);
+#endif
 	unregister_chrdev(I2C_MAJOR,"i2c");
 }
=20
diff -ru -N -x CVS lm_sensors-cvs/i2c/kernel/i2c-dev.h lm_sensors-lk2-4/i2c=
/kernel/i2c-dev.h
--- lm_sensors-cvs/i2c/kernel/i2c-dev.h	Tue Jan 21 00:08:16 2003
+++ lm_sensors-lk2-4/i2c/kernel/i2c-dev.h	Mon Jun 16 18:59:35 2003
@@ -19,28 +19,32 @@
     Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
 */
=20
 /* $Id: i2c-dev.h,v 1.13 2003/01/21 08:08:16 kmalkki Exp $ */
=20
 #ifndef _LINUX_I2C_DEV_H
 #define _LINUX_I2C_DEV_H
=20
 #include <linux/types.h>
=20
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2,4,18)
+#define minor(d) MINOR(d)
+#endif
+
 /* Some IOCTL commands are defined in <linux/i2c.h> */
 /* Note: 10-bit addresses are NOT supported! */
=20
 /* This is the structure as used in the I2C_SMBUS ioctl call */
 struct i2c_smbus_ioctl_data {
-	char read_write;
+	__u8 read_write;
 	__u8 command;
-	int size;
+	__u32 size;
 	union i2c_smbus_data *data;
 };
=20
 /* This is the structure as used in the I2C_RDWR ioctl call */
 struct i2c_rdwr_ioctl_data {
 	struct i2c_msg *msgs;	/* pointers to i2c_msgs */
-	int nmsgs;		/* number of i2c_msgs */
+	__u32 nmsgs;		/* number of i2c_msgs */
 };
=20
 #endif /* _LINUX_I2C_DEV_H */
diff -ru -N -x CVS lm_sensors-cvs/i2c/kernel/i2c-id.h lm_sensors-lk2-4/i2c/=
kernel/i2c-id.h
--- lm_sensors-cvs/i2c/kernel/i2c-id.h	Fri May 30 17:13:42 2003
+++ lm_sensors-lk2-4/i2c/kernel/i2c-id.h	Thu Jul  3 15:50:47 2003
@@ -152,6 +152,7 @@
 #define I2C_DRIVERID_FS451 1037
 #define I2C_DRIVERID_W83627HF 1038
 #define I2C_DRIVERID_LM85 1039
+#define I2C_DRIVERID_LM83 1040
=20
 /*
  * ---- Adapter types ----------------------------------------------------
diff -ru -N -x CVS lm_sensors-cvs/i2c/kernel/i2c-iop3xx.c lm_sensors-lk2-4/=
i2c/kernel/i2c-iop3xx.c
--- lm_sensors-cvs/i2c/kernel/i2c-iop3xx.c	Fri May 30 07:46:39 2003
+++ lm_sensors-lk2-4/i2c/kernel/i2c-iop3xx.c	Wed Dec 31 16:00:00 1969
@@ -1,624 +0,0 @@
-/* -----------------------------------------------------------------------=
-- */
-/* i2c-iop3xx.c i2c driver algorithms for Intel XScale IOP3xx             =
   */
-/* -----------------------------------------------------------------------=
-- */
-/*   Copyright (C) 2003 Peter Milne, D-TACQ Solutions Ltd
- *                      <Peter dot Milne at D hyphen TACQ dot com>
-
-    This program is free software; you can redistribute it and/or modify
-    it under the terms of the GNU General Public License as published by
-    the Free Software Foundation; either version 2 of the License.
-
-
-    This program is distributed in the hope that it will be useful,
-    but WITHOUT ANY WARRANTY; without even the implied warranty of
-    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-    GNU General Public License for more details.
-
-    You should have received a copy of the GNU General Public License
-    along with this program; if not, write to the Free Software
-    Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.             =
   */
-/* -----------------------------------------------------------------------=
-- */
-/*
-   With acknowledgements to i2c-algo-ibm_ocp.c by=20
-   Ian DaSilva, MontaVista Software, Inc. idasilva@mvista.com
-
-   And i2c-algo-pcf.c, which was created by Simon G. Vogl and Hans Berglun=
d:
-
-     Copyright (C) 1995-1997 Simon G. Vogl, 1998-2000 Hans Berglund
-  =20
-   And which acknowledged Ky=F6sti M=E4lkki <kmalkki@cc.hut.fi>,
-   Frodo Looijaard <frodol@dds.nl>, Martin Bailey<mbailey@littlefeet-inc.c=
om>
-
-  ------------------------------------------------------------------------=
---*/
-
-
-#include <linux/interrupt.h>
-#include <linux/kernel.h>
-#include <linux/module.h>
-#include <linux/delay.h>
-#include <linux/slab.h>
-#include <linux/init.h>
-#include <linux/errno.h>
-#include <linux/sched.h>
-#include <linux/i2c.h>
-
-
-#include <asm/arch-iop3xx/iop321.h>
-#include <asm/arch-iop3xx/iop321-irqs.h>
-#include "i2c-iop3xx.h"
-
-
-/* ----- global defines ----------------------------------------------- */
-#define PASSERT(x) do { if (!(x) ) \
-                printk(KERN_CRIT "PASSERT %s in %s:%d\n", #x, __FILE__, __=
LINE__ );\
-        } while (0)
-#define DEB(x) if (i2c_debug>=3D1) x
-#define DEB2(x) if (i2c_debug>=3D2) x
-#define DEB3(x) if (i2c_debug>=3D3) x /* print several statistical values*/
-#define DEBPROTO(x) if (i2c_debug>=3D9) x;
- 	/* debug the protocol by showing transferred bits */
-
-
-/* ----- global variables ---------------------------------------------	*/
-
-
-/* module parameters:
- */
-static int i2c_debug =3D 1;
-
-
-static inline unsigned char iic_cook_addr(struct i2c_msg *msg)=20
-{
-	unsigned char addr;
-
-	addr =3D ( msg->addr << 1 );
-
-	if (msg->flags & I2C_M_RD )
-		addr |=3D 1;
-
-/* PGM: what is M_REV_DIR_ADDR - do we need it ?? */
-	if (msg->flags & I2C_M_REV_DIR_ADDR )
-		addr ^=3D 1;
-
-	return addr;  =20
-}
-
-
-static inline void iop3xx_adap_reset(struct i2c_algo_iop3xx_data *iop3xx_a=
dap)
-{
-	// Follows devman 9.3
-	*iop3xx_adap->biu->CR =3D IOP321_ICR_UNIT_RESET;
-	*iop3xx_adap->biu->SR =3D IOP321_ISR_CLEARBITS;
-	*iop3xx_adap->biu->CR =3D 0;
-}=20
-
-static inline void iop3xx_adap_set_slave_addr(
-	struct i2c_algo_iop3xx_data *iop3xx_adap )
-{
-	*iop3xx_adap->biu->SAR =3D MYSAR;
-}
-
-static inline void iop3xx_adap_enable(=20
-	struct i2c_algo_iop3xx_data *iop3xx_adap )
-{
-	u32 cr =3D IOP321_ICR_GCD|IOP321_ICR_SCLEN|IOP321_ICR_UE;
-
-/* NB SR bits not same position as CR IE bits :-( */
-	iop3xx_adap->biu->SR_enabled =3D=20
-		IOP321_ISR_ALD|IOP321_ISR_BERRD|
-		IOP321_ISR_RXFULL|IOP321_ISR_TXEMPTY;
-
-	cr |=3D IOP321_ICR_ALDIE|IOP321_ICR_BERRIE|
-		IOP321_ICR_RXFULLIE|IOP321_ICR_TXEMPTYIE;
-
-	*iop3xx_adap->biu->CR =3D cr;
-}
-
-static void iop3xx_adap_transaction_cleanup(=20
-	struct i2c_algo_iop3xx_data *iop3xx_adap )
-{
-	unsigned cr =3D *iop3xx_adap->biu->CR;
-=09
-	cr &=3D ~(IOP321_ICR_MSTART | IOP321_ICR_TBYTE |=20
-		IOP321_ICR_MSTOP | IOP321_ICR_SCLEN );
-	*iop3xx_adap->biu->CR =3D cr;
-}
-
-static void iop3xx_adap_final_cleanup(=20
-	struct i2c_algo_iop3xx_data *iop3xx_adap )
-{
-	unsigned cr =3D *iop3xx_adap->biu->CR;
-=09
-	cr &=3D ~(IOP321_ICR_ALDIE|IOP321_ICR_BERRIE|
-		IOP321_ICR_RXFULLIE|IOP321_ICR_TXEMPTYIE);
-	iop3xx_adap->biu->SR_enabled =3D 0;
-	*iop3xx_adap->biu->CR =3D cr;
-}
-
-
-
-static void iop3xx_i2c_handler( int this_irq,=20
-				void *dev_id,=20
-				struct pt_regs *regs)=20
-/*=20
- * NB: the handler has to clear the source of the interrupt!=20
- * Then it passes the SR flags of interest to BH via adap data
- */
-{
-#define DFN KERN_DEBUG "iop3xx_i2c_handler() "
-	struct i2c_algo_iop3xx_data *iop3xx_adap =3D dev_id;
-
-	u32 sr =3D *iop3xx_adap->biu->SR;
-
-	DEB2(printk(DFN" SR 0x%08x jiffies %10ld\n", sr, jiffies ));
-
-	if ( (sr &=3D iop3xx_adap->biu->SR_enabled) ){
-		*iop3xx_adap->biu->SR =3D sr;
-		iop3xx_adap->biu->SR_received |=3D sr;
-		DEB2(printk(DFN"  wake client for 0x%08x\n",=20
-			    iop3xx_adap->biu->SR_received ));
-		wake_up_interruptible(&iop3xx_adap->waitq);
-	}else{
-		DEB(printk(DFN"Interrupt with no status 0x%08x\n", sr ) );
-	}
-#undef DFN
-}
-
-
-static int iop3xx_adap_error( u32 sr )
-// check all error conditions, clear them , report most important
-{
-	int rc =3D 0;
-
-	if ( (sr&IOP321_ISR_BERRD) ) {
-		if ( !rc ) rc =3D -I2C_ERR_BERR;
-	}
-	if ( (sr&IOP321_ISR_ALD) ){
-		if ( !rc ) rc =3D -I2C_ERR_ALD;	=09
-	}
-	return rc;=09
-}
-
-static inline u32 get_srstat( struct i2c_algo_iop3xx_data *iop3xx_adap  )
-{
-#define DFN KERN_DEBUG "get_srstat() "
-	unsigned long flags;
-	u32 sr;
-
-	DEB2(printk(DFN" enter lock\n" ));
-
-	spin_lock_irqsave( &iop3xx_adap->lock, flags );
-	sr =3D iop3xx_adap->biu->SR_received;
-	iop3xx_adap->biu->SR_received =3D 0;
-	spin_unlock_irqrestore( &iop3xx_adap->lock, flags );
-
-	DEB2(printk(DFN" leave lock\n" ));
-
-	return sr;
-#undef DFN
-}
-
-/*
- * sleep until interrupted, then recover and analyse the SR
- * saved by handler
- */
-typedef int (* CompareFunc)( unsigned test, unsigned mask );
-/* returns 1 on correct comparison */
-
-static int iop3xx_adap_wait_event( struct i2c_algo_iop3xx_data *iop3xx_ada=
p,=20
-			    unsigned flags, unsigned* status,
-			    CompareFunc compare )
-{
-#define DFN KERN_DEBUG "adap_wait_event() "
-	unsigned sr =3D 0;
-	int interrupted;
-	int done;
-	int rc;
-
-	long jiffies1 =3D jiffies;
-
-	do {
-		interrupted =3D wait_event_interruptible_timeout (
-			iop3xx_adap->waitq,
-			(done =3D compare( sr =3D get_srstat(iop3xx_adap),flags )),
-			iop3xx_adap->timeout
-			);
-		if ( (rc =3D iop3xx_adap_error( sr )) < 0 ){
-			*status =3D sr;
-			return rc;
-		}else if ( !interrupted ){
-			*status =3D sr;
-			DEB(printk(DFN "TIMEOUT %ld\n", jiffies ));
-			return rc =3D -ETIMEDOUT;
-		}
-	} while( !done );
-
-	*status =3D sr;
-
-	DEB3(printk( DFN"%ld %ld\n", jiffies1, jiffies ) );
-
-	return rc =3D 0;
-#undef DFN
-}
-
-
-
-
-/*
- * Concrete CompareFuncs=20
- */
-static int all_bits_clear( unsigned test, unsigned mask ) {
-	return (test&mask) =3D 0;
-}
-static int any_bits_set( unsigned test, unsigned mask ) {
-	return (test&mask) !=3D 0;
-}
-
-
-static int iop3xx_adap_wait_tx_done(
-	struct i2c_algo_iop3xx_data *iop3xx_adap, int *status)
-{
-	return iop3xx_adap_wait_event(=20
-		iop3xx_adap,=20
-	        IOP321_ISR_TXEMPTY|IOP321_ISR_ALD|IOP321_ISR_BERRD,
-		status, any_bits_set );
-}
-
-static int iop3xx_adap_wait_rx_done(
-	struct i2c_algo_iop3xx_data *iop3xx_adap, int *status)
-{
-	return iop3xx_adap_wait_event(=20
-		iop3xx_adap,=20
-		IOP321_ISR_RXFULL|IOP321_ISR_ALD|IOP321_ISR_BERRD,
-		status,	any_bits_set );
-}
-
-static int iop3xx_adap_wait_idle(
-	struct i2c_algo_iop3xx_data *iop3xx_adap, int *status)
-{
-	return iop3xx_adap_wait_event(=20
-		iop3xx_adap, IOP321_ISR_UNITBUSY, status, all_bits_clear );
-}
-
-//
-// Description: This performs the IOP3xx initialization sequence
-// Valid for IOP321. Maybe valid for IOP310?.
-//
-static int iop3xx_adap_init (struct i2c_algo_iop3xx_data *iop3xx_adap)
-{
-	*IOP321_GPOD &=3D ~(iop3xx_adap->channel=3D0?
-			  IOP321_GPOD_I2C0:
-			  IOP321_GPOD_I2C1);
-
-	iop3xx_adap_reset( iop3xx_adap );
-	iop3xx_adap_set_slave_addr( iop3xx_adap );
-	iop3xx_adap_enable( iop3xx_adap );
-=09
-        DEB2(printk(KERN_DEBUG "iic_init: Initialized IIC on IOP3xx\n"));
-        return 0;
-}
-
-static int iop3xx_adap_send_target_slave_addr(=20
-	struct i2c_algo_iop3xx_data *iop3xx_adap, struct i2c_msg* msg )
-{
-#define DFN KERN_DEBUG "iop3xx_adap_send_target_slave_addr() "
-	unsigned cr =3D *iop3xx_adap->biu->CR;
-	int status;
-	int rc;
-
-	*iop3xx_adap->biu->DBR =3D iic_cook_addr( msg );
-=09
-	cr &=3D ~(IOP321_ICR_MSTOP|IOP321_ICR_NACK);
-	cr |=3D IOP321_ICR_MSTART | IOP321_ICR_TBYTE;
-
-	*iop3xx_adap->biu->CR =3D cr;
-	rc =3D iop3xx_adap_wait_tx_done( iop3xx_adap, &status );
-/* this assert fires every time, contrary to IOP manual=09
-	PASSERT( (status&IOP321_ISR_UNITBUSY)!=3D0 );
-*/
-	PASSERT( (status&IOP321_ISR_RXREAD)=3D0 );
-	    =20
-	if ( rc < 0 ){
-		DEB2(printk( DFN "ERROR status 0x%02x\n", status ) );=20
-	}
-	return rc;
-#undef DFN
-}
-
-static int iop3xx_adap_write_byte(=20
-	struct i2c_algo_iop3xx_data *iop3xx_adap, char byte, int stop )
-{
-#define DFN KERN_DEBUG "iop3xx_iop3xx_adap_write_byte()"
-	unsigned cr =3D *iop3xx_adap->biu->CR;
-	int status;
-	int rc;
-
-	*iop3xx_adap->biu->DBR =3D byte;
-	cr &=3D ~IOP321_ICR_MSTART;
-	if ( stop ){
-		cr |=3D IOP321_ICR_MSTOP;
-	}else{
-		cr &=3D ~IOP321_ICR_MSTOP;
-	}
-	*iop3xx_adap->biu->CR =3D cr |=3D IOP321_ICR_TBYTE;
-	rc =3D iop3xx_adap_wait_tx_done( iop3xx_adap, &status );
-
-	if ( rc !=3D 0 ){
-		DEB(printk( DFN" ERROR status 0x%02x\n", status ));
-	}
-	return rc;
-#undef DFN
-}=20
-
-static int iop3xx_adap_read_byte(
-	struct i2c_algo_iop3xx_data *iop3xx_adap, char* byte, int stop )
-{
-#define DFN KERN_DEBUG "iop3xx_iop3xx_adap_read_byte()"
-	unsigned cr =3D *iop3xx_adap->biu->CR;
-	int status;
-	int rc;
-
-	cr &=3D ~IOP321_ICR_MSTART;
-
-	if ( stop ){
-		cr |=3D IOP321_ICR_MSTOP|IOP321_ICR_NACK;
-	}else{
-		cr &=3D ~(IOP321_ICR_MSTOP|IOP321_ICR_NACK);
-	}
-	*iop3xx_adap->biu->CR =3D cr |=3D IOP321_ICR_TBYTE;
-
-	rc =3D iop3xx_adap_wait_rx_done( iop3xx_adap, &status );
-
-	*byte =3D *iop3xx_adap->biu->DBR;
-
-	if ( rc !=3D 0 ){
-		DEB(printk( DFN" ERROR status 0x%02x\n", status ));
-	}=09
-	return rc;
-#undef DFN
-}
-
-
-static int iop3xx_i2c_writebytes( struct i2c_adapter *i2c_adap,=20
-				  const char *buf, int count )
-{
-	struct i2c_algo_iop3xx_data *iop3xx_adap =3D i2c_adap->algo_data;
-	int ii;
-	int rc =3D 0;
-
-	for ( ii =3D 0; rc =3D 0 && ii !=3D count; ++ii ){
-		rc =3D iop3xx_adap_write_byte(iop3xx_adap, buf[ii], ii=3Dcount-1);
-	}
-	return rc;
-}
-
-
-static int iop3xx_i2c_readbytes( struct i2c_adapter *i2c_adap,=20
-				 char *buf, int count )
-{
-	struct i2c_algo_iop3xx_data *iop3xx_adap =3D i2c_adap->algo_data;
-	int ii;
-	int rc =3D 0;
-
-	for ( ii =3D 0; rc =3D 0 && ii !=3D count; ++ii ){
-		rc =3D iop3xx_adap_read_byte(iop3xx_adap, &buf[ii], ii=3Dcount-1);
-	}
-	return rc;
-}
-
-
-/*
- * Description:  This function implements combined transactions.  Combined
- * transactions consist of combinations of reading and writing blocks of d=
ata.
- * FROM THE SAME ADDRESS
- * Each transfer (i.e. a read or a write) is separated by a repeated start
- * condition.
- */
-
-static int iop3xx_handle_msg(
-	struct i2c_adapter *i2c_adap, struct i2c_msg* pmsg )=20
-{
-	struct i2c_algo_iop3xx_data *iop3xx_adap =3D i2c_adap->algo_data;
-	int rc;
-
-	rc =3D iop3xx_adap_send_target_slave_addr( iop3xx_adap, pmsg );
-	if ( rc < 0 ){
-		return rc;
-	}
-
-	if ( (pmsg->flags&I2C_M_RD) ){
-		return iop3xx_i2c_readbytes( i2c_adap, pmsg->buf, pmsg->len );
-	}else{
-		return iop3xx_i2c_writebytes( i2c_adap, pmsg->buf, pmsg->len );
-	}
-}
-
-
-
-/*
- * master_xfer() - main read/write entry
- */
-static int iop3xx_master_xfer(
-	struct i2c_adapter *i2c_adap, struct i2c_msg msgs[], int num )
-{
-#define DFN KERN_DEBUG "iop3xx_master_xfer()"
-	struct i2c_algo_iop3xx_data *iop3xx_adap =3D i2c_adap->algo_data;
-	int im =3D 0;
-	int ret =3D 0;
-	int status;
-
-	DEB2(printk(DFN "Waiting completion any pending transfers\n"));
-	iop3xx_adap_wait_idle( iop3xx_adap, &status );
-#ifdef PGMCOMOUT
-	DEB2(printk(DFN "init - this may not be necessary _every_ time\n"));
-	iop3xx_adap_init(iop3xx_adap);
-#else
-	iop3xx_adap_reset( iop3xx_adap );
-	iop3xx_adap_enable( iop3xx_adap );
-#endif
-	for ( im =3D 0; ret =3D 0 && im !=3D num; ++im ){
-		ret =3D iop3xx_handle_msg( i2c_adap, &msgs[im] );
-	}
-
-	iop3xx_adap_transaction_cleanup( iop3xx_adap );
-
-	DEB2( if ( ret!=3D0 ) printk(DFN" ERROR return %d [%d]\n", ret, im ) );
-	return ret;  =20
-#undef DFN
-}
-
-
-
-static int algo_control(struct i2c_adapter *adapter,=20
-	unsigned int cmd, unsigned long arg)
-{
-	return 0;
-}
-
-
-static u32 iic_func(struct i2c_adapter *adap)
-{
-	return I2C_FUNC_I2C|I2C_FUNC_SMBUS_EMUL;
-}
-
-
-/* -----exported algorithm data: -------------------------------------	*/
-
-static struct i2c_algorithm iic_algo =3D {
-	.name		=3D "IOP3xx I2C algorithm",
-	.id		=3D I2C_ALGO_OCP_IOP3XX,
-	.master_xfer	=3D iop3xx_master_xfer,
-	.algo_control	=3D algo_control,
-	.functionality	=3D iic_func,
-};
-
-/*=20
- * registering functions to load algorithms at runtime=20
- */
-
-
-static int i2c_iop3xx_add_bus(struct i2c_adapter *iic_adap)
-{
-#define DFN KERN_DEBUG "i2c_iop3xx_add_bus() "
-	struct i2c_algo_iop3xx_data *iop3xx_adap =3D iic_adap->algo_data;
-
-	DEB2(printk(DFN": hw routines for %s registered.\n", iic_adap->name));
-
-	if ( !request_region( REGION_START(iop3xx_adap),=20
-			      REGION_LENGTH(iop3xx_adap),
-			      iic_adap->name ) ){
-		return -ENODEV;
-	}
-			     =20
-	init_waitqueue_head( &iop3xx_adap->waitq );
-	spin_lock_init( &iop3xx_adap->lock );
-
-	if ( request_irq(=20
-		     iop3xx_adap->biu->irq,
-		     iop3xx_i2c_handler,
-		     /* SA_SAMPLE_RANDOM */ 0,
-		     iic_adap->name,
-		     iop3xx_adap )          ){
-		return -ENODEV;
-	}			 =20
-
-/* register new iic_adapter to i2c module... */
-
-	iic_adap->id |=3D iic_algo.id;
-	iic_adap->algo =3D &iic_algo;
-
-	iic_adap->timeout =3D 100;	/* default values, should	*/
-	iic_adap->retries =3D 3;		/* be replaced by defines	*/
-
-	iop3xx_adap_init( iic_adap->algo_data );
-	i2c_add_adapter(iic_adap);
-	return 0;
-#undef DFN
-}
-
-
-static int i2c_iop3xx_del_bus(struct i2c_adapter *iic_adap)
-{
-	struct i2c_algo_iop3xx_data *iop3xx_adap =3D iic_adap->algo_data;
-
-	iop3xx_adap_final_cleanup( iop3xx_adap );
-	free_irq( iop3xx_adap->biu->irq, iop3xx_adap );
-
-	release_region( REGION_START(iop3xx_adap), REGION_LENGTH(iop3xx_adap));
-
-	return i2c_del_adapter( iic_adap );
-}
-
-#ifdef CONFIG_ARCH_IOP321
-
-static struct iop3xx_biu biu0 =3D {
-	.CR     =3D IOP321_ICR0,
-	.SR     =3D IOP321_ISR0,
-	.SAR    =3D IOP321_ISAR0,
-	.DBR    =3D IOP321_IDBR0,
-	.BMR    =3D IOP321_IBMR0,
-	.irq    =3D IRQ_IOP321_I2C_0
-};
-
-static struct iop3xx_biu biu1 =3D {
-	.CR     =3D IOP321_ICR1,
-	.SR     =3D IOP321_ISR1,
-	.SAR    =3D IOP321_ISAR1,
-	.DBR    =3D IOP321_IDBR1,
-	.BMR    =3D IOP321_IBMR1,
-	.irq    =3D IRQ_IOP321_I2C_1
-};
-
-#define ADAPTER_NAME_ROOT "IOP321 i2c biu adapter "
-#else
-#error Please define the BIU struct iop3xx_biu for your processor arch
-#endif
-
-static struct i2c_algo_iop3xx_data  algo_iop3xx_data0 =3D {
-	.channel                =3D 0,
-	.biu                    =3D &biu0,
-	.timeout                =3D 1*HZ
-};
-static struct i2c_algo_iop3xx_data  algo_iop3xx_data1 =3D {
-        .channel                =3D 1,
-	.biu                    =3D &biu1,
-	.timeout                =3D 1*HZ
-};
-
-static struct i2c_adapter iop3xx_ops0 =3D {
-	.owner			=3D THIS_MODULE,
-	.name			=3D ADAPTER_NAME_ROOT "0",
-	.id			=3D I2C_HW_IOP321,
-	.algo_data		=3D &algo_iop3xx_data0
-};
-static struct i2c_adapter iop3xx_ops1 =3D {
-	.owner			=3D THIS_MODULE,
-	.name			=3D ADAPTER_NAME_ROOT "1",
-	.id			=3D I2C_HW_IOP321,
-	.algo_data		=3D &algo_iop3xx_data1
-};
-
-static int __init i2c_iop3xx_init (void)
-{
-	return i2c_iop3xx_add_bus(&iop3xx_ops0) ||
-		i2c_iop3xx_add_bus(&iop3xx_ops1);
-}
-
-static void __exit i2c_iop3xx_exit (void)
-{
-	i2c_iop3xx_del_bus(&iop3xx_ops0);
-	i2c_iop3xx_del_bus(&iop3xx_ops1);
-}
-
-module_init (i2c_iop3xx_init);
-module_exit (i2c_iop3xx_exit);
-
-MODULE_AUTHOR("D-TACQ Solutions Ltd <www.d-tacq.com>");
-MODULE_DESCRIPTION("IOP3xx iic algorithm and driver");
-MODULE_LICENSE("GPL");
-
-MODULE_PARM(i2c_debug,"i");
-
-MODULE_PARM_DESC(i2c_debug,
-        "debug level - 0 off; 1 normal; 2,3 more verbose; 9 iic-protocol");
-
diff -ru -N -x CVS lm_sensors-cvs/i2c/kernel/i2c-iop3xx.h lm_sensors-lk2-4/=
i2c/kernel/i2c-iop3xx.h
--- lm_sensors-cvs/i2c/kernel/i2c-iop3xx.h	Fri May 30 07:46:39 2003
+++ lm_sensors-lk2-4/i2c/kernel/i2c-iop3xx.h	Wed Dec 31 16:00:00 1969
@@ -1,120 +0,0 @@
-/* -----------------------------------------------------------------------=
-- */
-/* i2c-iop3xx.h algorithm driver definitions private to i2c-iop3xx.c      =
   */
-/* -----------------------------------------------------------------------=
-- */
-/*   Copyright (C) 2003 Peter Milne, D-TACQ Solutions Ltd
- *                      <Peter dot Milne at D hyphen TACQ dot com>
-
-    This program is free software; you can redistribute it and/or modify
-    it under the terms of the GNU General Public License as published by
-    the Free Software Foundation; either version 2 of the License.
-
-    This program is distributed in the hope that it will be useful,
-    but WITHOUT ANY WARRANTY; without even the implied warranty of
-    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-    GNU General Public License for more details.
-
-    You should have received a copy of the GNU General Public License
-    along with this program; if not, write to the Free Software
-    Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.             =
   */
-/* -----------------------------------------------------------------------=
-- */
-
-
-#ifndef I2C_IOP3XX_H
-#define I2C_IOP3XX_H 1
-
-/*
- * iop321 hardware bit definitions
- */
-#define IOP321_ICR_FAST_MODE  0x8000 /* 1@0kBps, 0=100kBps */
-#define IOP321_ICR_UNIT_RESET 0x4000 /* 1=3DRESET */
-#define IOP321_ICR_SADIE      0x2000 /* 1=3DSlave Detect Interrupt Enable =
*/
-#define IOP321_ICR_ALDIE      0x1000 /* 1=3DArb Loss Detect Interrupt Enab=
le */
-#define IOP321_ICR_SSDIE      0x0800 /* 1=3DSlave STOP Detect Interrupt En=
able */
-#define IOP321_ICR_BERRIE     0x0400 /* 1=3DBus Error Interrupt Enable */
-#define IOP321_ICR_RXFULLIE   0x0200 /* 1=3DReceive Full Interrupt Enable =
*/
-#define IOP321_ICR_TXEMPTYIE  0x0100 /* 1=3DTransmit Empty Interrupt Enabl=
e */
-#define IOP321_ICR_GCD        0x0080 /* 1=3DGeneral Call Disable */
-/*
- * IOP321_ICR_GCD: 1 disables response as slave. "This bit must be set
- * when sending a master mode general call message from the I2C unit"
- */
-#define IOP321_ICR_UE         0x0040 /* 1=3DUnit Enable */
-/*
- * "NOTE: To avoid I2C bus integrity problems,=20
- * the user needs to ensure that the GPIO Output Data Register -=20
- * GPOD bits associated with an I2C port are cleared prior to setting=20
- * the enable bit for that I2C serial port.=20
- * The user prepares to enable I2C port 0 and=20
- * I2C port 1 by clearing GPOD bits 7:6 and GPOD bits 5:4, respectively.
- */                                    =20
-#define IOP321_ICR_SCLEN     0x0020 /* 1=3DSCL enable for master mode */
-#define IOP321_ICR_MABORT    0x0010 /* 1=3DSend a STOP with no data=20
-                                     * NB TBYTE must be clear       */
-#define IOP321_ICR_TBYTE     0x0008 /* 1=3DSend/Receive a byte. i2c clears=
 */
-#define IOP321_ICR_NACK      0x0004 /* 1=3Dreply with NACK */
-#define IOP321_ICR_MSTOP     0x0002 /* 1=3Dsend a STOP after next data byt=
e */
-#define IOP321_ICR_MSTART    0x0001 /* 1=3Dinitiate a START */
-
-
-#define IOP321_ISR_BERRD     0x0400 /* 1=3DBUS ERROR Detected */
-#define IOP321_ISR_SAD       0x0200 /* 1=3DSlave ADdress Detected */
-#define IOP321_ISR_GCAD      0x0100 /* 1=3DGeneral Call Address Detected */
-#define IOP321_ISR_RXFULL    0x0080 /* 1=3DReceive Full */
-#define IOP321_ISR_TXEMPTY   0x0040 /* 1=3DTransmit Empty */
-#define IOP321_ISR_ALD       0x0020 /* 1=3DArbitration Loss Detected */
-#define IOP321_ISR_SSD       0x0010 /* 1=3DSlave STOP Detected */
-#define IOP321_ISR_BBUSY     0x0008 /* 1=3DBus BUSY */
-#define IOP321_ISR_UNITBUSY  0x0004 /* 1=3DUnit Busy */
-#define IOP321_ISR_NACK      0x0002 /* 1=3DUnit Rx or Tx a NACK */
-#define IOP321_ISR_RXREAD    0x0001 /* 1=3DREAD 0=3DWRITE (R/W bit of slav=
e addr */
-
-#define IOP321_ISR_CLEARBITS 0x07f0
-
-#define IOP321_ISAR_SAMASK   0x007f=20
-
-#define IOP321_IDBR_MASK     0x00ff
-
-#define IOP321_IBMR_SCL      0x0002
-#define IOP321_IBMR_SDA      0x0001
-
-#define IOP321_GPOD_I2C0     0x00c0  /* clear these bits to enable ch0 */
-#define IOP321_GPOD_I2C1     0x0030  /* clear these bits to enable ch1 */
-
-#define MYSAR                0x02     /* SWAG a suitable slave address */
-
-#define I2C_ERR              321
-#define I2C_ERR_BERR         (I2C_ERR+0)
-#define I2C_ERR_ALD          (I2C_ERR+1)
-
-
-typedef volatile u32* r32;
-
-struct iop3xx_biu {                /* Bus Interface Unit - the hardware */
-/* physical hardware defs - regs*/
-	r32 CR;
-	r32 SR;
-	r32 SAR;
-	r32 DBR;
-	r32 BMR;
-/* irq bit vector */
-	u32 irq;
-/* stored flags */
-	u32 SR_enabled, SR_received;
-};
-
-struct i2c_algo_iop3xx_data {
-	int channel;
-
-	wait_queue_head_t waitq;
-	spinlock_t lock;
-	int timeout;
-	struct iop3xx_biu* biu;
-};
-
-#define REGION_START( adap )  ((u32)((adap)->biu->CR))
-#define REGION_END( adap )    ((u32)((adap)->biu->BMR+1))
-#define REGION_LENGTH( adap ) (REGION_END(adap)-REGION_START(adap))
-
-#define IRQ_STATUS_MASK( adap ) (1<<adap->biu->irq)
-
-#endif /* I2C_IOP3XX_H */
diff -ru -N -x CVS lm_sensors-cvs/i2c/kernel/i2c-proc.c lm_sensors-lk2-4/i2=
c/kernel/i2c-proc.c
--- lm_sensors-cvs/i2c/kernel/i2c-proc.c	Sat Mar  8 17:01:33 2003
+++ lm_sensors-lk2-4/i2c/kernel/i2c-proc.c	Tue Jun 10 18:55:26 2003
@@ -35,11 +35,9 @@
 #include "i2c-proc.h"
 #include <asm/uaccess.h>
=20
-static int i2c_create_name(char **name, const char *prefix,
-			       struct i2c_adapter *adapter, int addr);
 static int i2c_parse_reals(int *nrels, void *buffer, int bufsize,
 			       long *results, int magnitude);
-static int i2c_write_reals(int nrels, void *buffer, int *bufsize,
+static int i2c_write_reals(int nrels, void *buffer, size_t *bufsize,
 			       long *results, int magnitude);
 static int i2c_proc_chips(ctl_table * ctl, int write,
 			      struct file *filp, void *buffer,
@@ -54,15 +52,6 @@
=20
 static struct i2c_client *i2c_clients[SENSORS_ENTRY_MAX];
=20
-static ctl_table sysctl_table[] =3D {
-	{CTL_DEV, "dev", NULL, 0, 0555},
-	{0},
-	{DEV_SENSORS, "sensors", NULL, 0, 0555},
-	{0},
-	{0, NULL, NULL, 0, 0555},
-	{0}
-};
-
 static ctl_table i2c_proc_dev_sensors[] =3D {
 	{SENSORS_CHIPS, "chips", NULL, 0, 0644, NULL, &i2c_proc_chips,
 	 &i2c_sysctl_chips},
@@ -70,13 +59,13 @@
 };
=20
 static ctl_table i2c_proc_dev[] =3D {
-	{DEV_SENSORS, "sensors", NULL, 0, 0555, i2c_proc_dev_sensors, NULL},
+	{DEV_SENSORS, "sensors", NULL, 0, 0555, i2c_proc_dev_sensors},
 	{0},
 };
=20
=20
 static ctl_table i2c_proc[] =3D {
-	{CTL_DEV, "dev", NULL, 0, 0555, i2c_proc_dev, NULL},
+	{CTL_DEV, "dev", NULL, 0, 0555, i2c_proc_dev},
 	{0}
 };
=20
@@ -87,36 +76,40 @@
    (for a LM78 chip on the ISA bus at port 0x310), or lm75-i2c-3-4e (for
    a LM75 chip on the third i2c bus at address 0x4e). =20
    name is allocated first. */
-static int i2c_create_name(char **name, const char *prefix,
-			struct i2c_adapter *adapter, int addr)
+static char *generate_name(struct i2c_client *client, const char *prefix)
 {
-	char name_buffer[50];
-	int id, i, end;
-	if (i2c_is_isa_adapter(adapter))
+	struct i2c_adapter *adapter =3D client->adapter;
+	int addr =3D client->addr;
+	char name_buffer[50], *name;
+
+	if (i2c_is_isa_adapter(adapter)) {
 		sprintf(name_buffer, "%s-isa-%04x", prefix, addr);
-	else if (!adapter->algo->smbus_xfer && !adapter->algo->master_xfer) {
-		/* dummy adapter, generate prefix */
+	} else if (adapter->algo->smbus_xfer || adapter->algo->master_xfer) {
+		int id =3D i2c_adapter_id(adapter);
+		if (id < 0)
+			return ERR_PTR(-ENOENT);
+		sprintf(name_buffer, "%s-i2c-%d-%02x", prefix, id, addr);
+	} else {	/* dummy adapter, generate prefix */
+		int end, i;
+
 		sprintf(name_buffer, "%s-", prefix);
 		end =3D strlen(name_buffer);
-		for(i =3D 0; i < 32; i++) {
-			if(adapter->algo->name[i] =3D ' ')
+
+		for (i =3D 0; i < 32; i++) {
+			if (adapter->algo->name[i] =3D ' ')
 				break;
 			name_buffer[end++] =3D tolower(adapter->algo->name[i]);
 		}
+
 		name_buffer[end] =3D 0;
 		sprintf(name_buffer + end, "-%04x", addr);
-	} else {
-		if ((id =3D i2c_adapter_id(adapter)) < 0)
-			return -ENOENT;
-		sprintf(name_buffer, "%s-i2c-%d-%02x", prefix, id, addr);
-	}
-	*name =3D kmalloc(strlen(name_buffer) + 1, GFP_KERNEL);
-	if (!*name) {
-		printk (KERN_WARNING "i2c_create_name: not enough memory\n");
-		return -ENOMEM;
 	}
-	strcpy(*name, name_buffer);
-	return 0;
+
+	name =3D kmalloc(strlen(name_buffer) + 1, GFP_KERNEL);
+	if (!name)
+		return ERR_PTR(-ENOMEM);
+	strcpy(name, name_buffer);
+	return name;
 }
=20
 /* This rather complex function must be called when you want to add an ent=
ry
@@ -127,93 +120,86 @@
    If any driver wants subdirectories within the newly created directory,
    this function must be updated!  */
 int i2c_register_entry(struct i2c_client *client, const char *prefix,
-			   ctl_table * ctl_template)
+		       struct ctl_table *ctl_template)
 {
-	int i, res, len, id;
-	ctl_table *new_table, *client_tbl, *tbl;
-	char *name;
-	struct ctl_table_header *new_header;
-
-	if ((res =3D i2c_create_name(&name, prefix, client->adapter,
-				       client->addr))) return res;
-
-	for (id =3D 0; id < SENSORS_ENTRY_MAX; id++)
-		if (!i2c_entries[id]) {
-			break;
-		}
-	if (id =3D SENSORS_ENTRY_MAX) {
-		kfree(name);
-		return -ENOMEM;
-	}
+	struct { struct ctl_table root[2], dev[2], sensors[2]; } *tbl;
+	struct ctl_table_header *hdr;
+	struct ctl_table *tmp, *leaf;
+	const char *name;
+	int id, len =3D 0;
=20
-	id +=3D 256;
-=09
-	len =3D 0;
-	while (ctl_template[len].procname)
-		len++;
-	if (!(new_table =3D kmalloc(sizeof(sysctl_table) + sizeof(ctl_table) * (l=
en + 1),=20
-				  GFP_KERNEL))) {
-		kfree(name);
-		return -ENOMEM;
-	}
+	name =3D generate_name(client, prefix);
+	if (IS_ERR(name))
+		return PTR_ERR(name);
=20
-	memcpy(new_table, sysctl_table, sizeof(sysctl_table));
-	tbl =3D new_table; /* sys/ */
-	tbl =3D tbl->child =3D tbl + 2; /* dev/ */
-	tbl =3D tbl->child =3D tbl + 2; /* sensors/ */=09
-       	client_tbl =3D tbl->child =3D tbl + 2; /* XX-chip-YY-ZZ/ */
-
-	client_tbl->procname =3D name;
-	client_tbl->ctl_name =3D id;
-	client_tbl->child =3D client_tbl + 2;
-
-	/* Next the client sysctls. --km */
-	tbl =3D client_tbl->child;
-	memcpy(tbl, ctl_template, sizeof(ctl_table) * (len+1));
-	for (i =3D 0; i < len; i++)
-		tbl[i].extra2 =3D client;
-
-	if (!(new_header =3D register_sysctl_table(new_table, 0))) {
-		printk(KERN_ERR "i2c-proc.o: error: sysctl interface not supported by ke=
rnel!\n");
-		kfree(new_table);
-		kfree(name);
-		return -EPERM;
+	for (id =3D 0; id < SENSORS_ENTRY_MAX; id++) {
+		if (!i2c_entries[id])
+			goto free_slot;
 	}
=20
- 	i2c_entries[id - 256] =3D new_header;
+	goto out_free_name;
=20
-	i2c_clients[id - 256] =3D client;
-
-#ifdef DEBUG
-	if (!new_header || !new_header->ctl_table ||
-	    !new_header->ctl_table->child ||
-	    !new_header->ctl_table->child->child ||
-	    !new_header->ctl_table->child->child->de ) {
-		printk
-		    (KERN_ERR "i2c-proc.o: NULL pointer when trying to install fill_inod=
e fix!\n");
-		return id;
-	}
-#endif				/* DEBUG */
-	client_tbl->de->owner =3D client->driver->owner;
-	return id;
+ free_slot:
+	while (ctl_template[len].procname)
+		len++;
+	tbl =3D kmalloc(sizeof(*tbl) + sizeof(ctl_table) * (len + 1),=20
+				  GFP_KERNEL);
+	if (!tbl)
+		goto out_free_name;
+	memset(tbl, 0, sizeof(*tbl));
+
+	/* The client sysctls */
+	leaf =3D (struct ctl_table *) (tbl + 1);
+	memcpy(leaf, ctl_template, sizeof(ctl_table) * (len+1));
+	for (tmp =3D leaf; tmp->ctl_name; tmp++)
+		tmp->extra2 =3D client;
+
+	tbl->sensors->ctl_name =3D id+256;
+	tbl->sensors->procname =3D name;
+	tbl->sensors->mode =3D 0555;
+	tbl->sensors->child =3D leaf;
+
+	tbl->dev->ctl_name =3D DEV_SENSORS;
+	tbl->dev->procname =3D "sensors";
+	tbl->dev->mode =3D 0555;
+	tbl->dev->child =3D tbl->sensors;
+
+	tbl->root->ctl_name =3D CTL_DEV;
+	tbl->root->procname =3D "dev";
+	tbl->root->mode =3D 0555;
+	tbl->root->child =3D tbl->dev;
+
+	hdr =3D register_sysctl_table(tbl->root, 0);
+	if (!hdr)
+		goto out_free_tbl;
+
+	i2c_entries[id] =3D hdr;
+	i2c_clients[id] =3D client;
+
+	return (id + 256);	/* XXX(hch) why?? */
+
+ out_free_tbl:
+	kfree(tbl);
+ out_free_name:
+	kfree(name);
+	return -ENOMEM;
 }
=20
 void i2c_deregister_entry(int id)
 {
-	ctl_table *table;
-	char *temp;
+	id -=3D 256;
=20
-	id -=3D 256;=09
 	if (i2c_entries[id]) {
-		table =3D i2c_entries[id]->ctl_table;
-		unregister_sysctl_table(i2c_entries[id]);
-		/* 2-step kfree needed to keep gcc happy about const points */
-		(const char *) temp =3D table[4].procname;
-		kfree(temp);
-		kfree(table);
-		i2c_entries[id] =3D NULL;
-		i2c_clients[id] =3D NULL;
+		struct ctl_table_header *hdr =3D i2c_entries[id];
+		struct ctl_table *tbl =3D hdr->ctl_table;
+
+		unregister_sysctl_table(hdr);
+		kfree(tbl->child->child->procname);
+		kfree(tbl); /* actually the whole anonymous struct */
 	}
+
+	i2c_entries[id] =3D NULL;
+	i2c_clients[id] =3D NULL;
 }
=20
 static int i2c_proc_chips(ctl_table * ctl, int write, struct file *filp,
@@ -517,7 +503,7 @@
 	return 0;
 }
=20
-static int i2c_write_reals(int nrels, void *buffer, int *bufsize,
+static int i2c_write_reals(int nrels, void *buffer, size_t *bufsize,
 			 long *results, int magnitude)
 {
 #define BUFLEN 20
diff -ru -N -x CVS lm_sensors-cvs/i2c/kernel/i2c-velleman.c lm_sensors-lk2-=
4/i2c/kernel/i2c-velleman.c
--- lm_sensors-cvs/i2c/kernel/i2c-velleman.c	Tue Jan 21 00:08:16 2003
+++ lm_sensors-lk2-4/i2c/kernel/i2c-velleman.c	Tue Jan 21 02:00:19 2003
@@ -18,12 +18,13 @@
     Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.		     */
 /* -----------------------------------------------------------------------=
-- */
=20
 /* $Id: i2c-velleman.c,v 1.29 2003/01/21 08:08:16 kmalkki Exp $ */
=20
 #include <linux/kernel.h>
 #include <linux/ioport.h>
 #include <linux/module.h>
 #include <linux/init.h>
+#include <linux/errno.h>
 #include <linux/delay.h>
 #include "i2c.h"
 #include "i2c-algo-bit.h"
diff -ru -N -x CVS lm_sensors-cvs/i2c/kernel/i2c.h lm_sensors-lk2-4/i2c/ker=
nel/i2c.h
--- lm_sensors-cvs/i2c/kernel/i2c.h	Tue Jan 21 00:08:16 2003
+++ lm_sensors-lk2-4/i2c/kernel/i2c.h	Sun Jun 22 13:49:51 2003
@@ -23,18 +23,24 @@
 /* With some changes from Ky=F6sti M=E4lkki <kmalkki@cc.hut.fi> and
    Frodo Looijaard <frodol@dds.nl> */
=20
 /* $Id: i2c.h,v 1.68 2003/01/21 08:08:16 kmalkki Exp $ */
=20
 #ifndef _LINUX_I2C_H
 #define _LINUX_I2C_H
=20
-#define I2C_DATE "20021208"
-#define I2C_VERSION "2.7.0"
+#define I2C_DATE "2003xxxx"
+#define I2C_VERSION "2.8.0-CVS"
=20
 #include <linux/module.h>
 #include <linux/types.h>
-#include "i2c-id.h"
+#include <linux/errno.h>
 #include <asm/semaphore.h>
+#include "i2c-id.h"
+
+#include <linux/version.h>
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2,4,10)
+#define MODULE_LICENSE(x)
+#endif
=20
 /* --- General options ------------------------------------------------	*/
=20
@@ -349,15 +355,15 @@
  */
 struct i2c_msg {
 	__u16 addr;	/* slave address			*/
-	unsigned short flags;	=09
+	__u16 flags;	=09
 #define I2C_M_TEN	0x10	/* we have a ten bit chip address	*/
 #define I2C_M_RD	0x01
 #define I2C_M_NOSTART	0x4000
 #define I2C_M_REV_DIR_ADDR	0x2000
 #define I2C_M_IGNORE_NAK	0x1000
 #define I2C_M_NO_RD_ACK		0x0800
-	short len;		/* msg length				*/
-	char *buf;		/* pointer to msg data			*/
+	__u16 len;		/* msg length				*/
+	__u8 *buf;		/* pointer to msg data			*/
 	int err;
 	short done;
 };
diff -ru -N -x CVS lm_sensors-cvs/i2c/mkpatch/Config.in lm_sensors-lk2-4/i2=
c/mkpatch/Config.in
--- lm_sensors-cvs/i2c/mkpatch/Config.in	Tue Jan 21 00:08:16 2003
+++ lm_sensors-lk2-4/i2c/mkpatch/Config.in	Mon Sep  9 17:34:27 2002
@@ -44,6 +44,9 @@
       fi
    fi
=20
+# This is needed for automatic patch generation: sensors code starts here
+# This is needed for automatic patch generation: sensors code ends here
+
    dep_tristate 'I2C device interface' CONFIG_I2C_CHARDEV $CONFIG_I2C
    dep_tristate 'I2C /proc interface (required for hardware sensors)' CONF=
IG_I2C_PROC $CONFIG_I2C $CONFIG_SYSCTL
=20
diff -ru -N -x CVS lm_sensors-cvs/i2c/mkpatch/FILES lm_sensors-lk2-4/i2c/mk=
patch/FILES
--- lm_sensors-cvs/i2c/mkpatch/FILES	Tue Jan 21 00:08:16 2003
+++ lm_sensors-lk2-4/i2c/mkpatch/FILES	Tue Jan 21 02:14:11 2003
@@ -1,32 +1,30 @@
-kernel/i2c-core.c		drivers/i2c/i2c-core.c
-kernel/i2c-dev.c		drivers/i2c/i2c-dev.c
-kernel/i2c-proc.c		drivers/i2c/i2c-proc.c
+kernel/i2c-adap-ibm_ocp.c	drivers/i2c/i2c-adap-ibm_ocp.c
 kernel/i2c-algo-8xx.c		drivers/i2c/i2c-algo-8xx.c
 kernel/i2c-algo-bit.c		drivers/i2c/i2c-algo-bit.c
-kernel/i2c-algo-biths.c		drivers/i2c/i2c-algo-biths.c
 kernel/i2c-algo-ibm_ocp.c	drivers/i2c/i2c-algo-ibm_ocp.c
 kernel/i2c-algo-pcf.c		drivers/i2c/i2c-algo-pcf.c
+kernel/i2c-core.c		drivers/i2c/i2c-core.c
+kernel/i2c-dev.c		drivers/i2c/i2c-dev.c
 kernel/i2c-elektor.c		drivers/i2c/i2c-elektor.c
 kernel/i2c-elv.c		drivers/i2c/i2c-elv.c
 kernel/i2c-frodo.c		drivers/i2c/i2c-frodo.c
 kernel/i2c-pcf-epp.c		drivers/i2c/i2c-pcf-epp.c
 kernel/i2c-philips-par.c	drivers/i2c/i2c-philips-par.c
 kernel/i2c-pport.c		drivers/i2c/i2c-pport.c
+kernel/i2c-proc.c		drivers/i2c/i2c-proc.c
 kernel/i2c-rpx.c		drivers/i2c/i2c-rpx.c
 kernel/i2c-velleman.c		drivers/i2c/i2c-velleman.c
 kernel/i2c.h			include/linux/i2c.h
-kernel/i2c-id.h			include/linux/i2c-id.h
 kernel/i2c-dev.h		include/linux/i2c-dev.h
-kernel/i2c-proc.h		include/linux/i2c-proc.h
 kernel/i2c-algo-8xx.h		include/linux/i2c-algo-8xx.h
 kernel/i2c-algo-bit.h		include/linux/i2c-algo-bit.h
-kernel/i2c-algo-biths.h		include/linux/i2c-algo-biths.h
 kernel/i2c-algo-ibm_ocp.h	include/linux/i2c-algo-ibm_ocp.h
 kernel/i2c-algo-pcf.h		include/linux/i2c-algo-pcf.h
+kernel/i2c-id.h			include/linux/i2c-id.h
 kernel/i2c-pcf8584.h		include/linux/i2c-pcf8584.h
+kernel/i2c-proc.h		include/linux/i2c-proc.h
 doc/dev-interface		Documentation/i2c/dev-interface
 doc/functionality		Documentation/i2c/functionality
-doc/i2c-old-porting		Documentation/i2c/i2c-old-porting
 doc/i2c-pport			Documentation/i2c/i2c-pport
 doc/i2c-protocol		Documentation/i2c/i2c-protocol
 doc/i2c-velleman		Documentation/i2c/i2c-velleman
diff -ru -N -x CVS lm_sensors-cvs/i2c/mkpatch/INCLUDES lm_sensors-lk2-4/i2c=
/mkpatch/INCLUDES
--- lm_sensors-cvs/i2c/mkpatch/INCLUDES	Tue Jan 21 00:08:16 2003
+++ lm_sensors-lk2-4/i2c/mkpatch/INCLUDES	Tue Jan 21 02:14:11 2003
@@ -1,10 +1,9 @@
 "i2c.h"			<linux/i2c.h>
-"i2c-id.h"		<linux/i2c-id.h>
 "i2c-dev.h"		<linux/i2c-dev.h>
-"i2c-proc.h"		<linux/i2c-proc.h>
 "i2c-algo-bit.h"	<linux/i2c-algo-bit.h>
-"i2c-algo-biths.h"	<linux/i2c-algo-biths.h>
 "i2c-algo-pcf.h"	<linux/i2c-algo-pcf.h>
 "i2c-pcf8584.h"		<linux/i2c-pcf8584.h>
+"i2c-id.h"		<linux/i2c-id.h>
+"i2c-proc.h"		<linux/i2c-proc.h>
 "i2c-algo-8xx.h"	<linux/i2c-algo-8xx.h>
 "i2c-algo-ibm_ocp.h"	<linux/i2c-algo-ibm_ocp.h>
diff -ru -N -x CVS lm_sensors-cvs/i2c/mkpatch/mkpatch.pl lm_sensors-lk2-4/i=
2c/mkpatch/mkpatch.pl
--- lm_sensors-cvs/i2c/mkpatch/mkpatch.pl	Tue Jan 21 00:08:16 2003
+++ lm_sensors-lk2-4/i2c/mkpatch/mkpatch.pl	Sun Jun 22 13:49:51 2003
@@ -37,22 +37,98 @@
   my ($package_root,$kernel_root,$kernel_file,$package_file) =3D @_;
   my ($diff_command,$dummy);
=20
-  $diff_command =3D "diff -u";
-  $diff_command .=3D " $kernel_root/$kernel_file ";
-  $diff_command .=3D " $package_root/$package_file ";
-  open INPUT, "$diff_command|" or die "Can't call `$diff_command'";
-  if (<INPUT>) {
-      print "--- linux-old/$kernel_file\t".`date`;
+  $diff_command =3D "diff -u2";
+  if ( -e "$kernel_root/$kernel_file") {
+    $diff_command .=3D " $kernel_root/$kernel_file ";
+  } else {
+    $diff_command .=3D " /dev/null ";
   }
-  if (<INPUT>) {
-      print "+++ linux/$kernel_file\t".`date`;
+  if ( -e "$package_root/$package_file") {
+    $diff_command .=3D " $package_root/$package_file ";
+  } else {
+    $diff_command .=3D " /dev/null";
   }
+  open INPUT, "$diff_command|" or die "Can't call `$diff_command'";
+  $dummy =3D <INPUT>;
+  $dummy =3D <INPUT>;
+  print "--- linux-old/$kernel_file\t".`date`;
+  print "+++ linux/$kernel_file\t".`date`;
+   =20
   while (<INPUT>) {
     print;
   }
   close INPUT;
 }
=20
+# Find all the lm_sensors code in a file
+# $_[0]: Linux kernel tree (like /usr/src/linux)
+# $_[1]: Name of the kernel file
+# Returns a list of strings with the sensors codes
+sub find_sensors_code
+{
+  my ($kernel_root,$kernel_file) =3D @_;
+  my @res;
+  open INPUT, "$kernel_root/$kernel_file"=20
+       or return @res;
+  while (<INPUT>) {
+    if (m@sensors code starts here@) {
+      push @res,"";
+      while (<INPUT>) {
+        last if m@sensors code ends here@;
+        $res[$#res] .=3D $_;
+      }
+    }
+  }
+  return @res;   =20
+}=20
+
+# Here we generate diffs for all kernel files mentioned in OLDI2C=20
+# which change the invocation # `#include <linux/i2c.h>' to=20
+# `#include <linux/i2c-old.h>'. But first, we generate diffs to copy
+# file <linux/i2c.h> to <linux/i2c-old.h>, if the kernel does not have
+# this file yet.
+# $_[0]: sensors package root (like /tmp/sensors)
+# $_[1]: Linux kernel tree (like /usr/src/linux)
+sub patch_old_i2c
+{
+  my ($package_root,$kernel_root) =3D @_;
+  my (@files,$file,$f);
+  # If i2c.c does not exist, either we renamed it earlier, or there is no
+  # i2c support in this kernel at all.
+  return if not -e "$kernel_root/drivers/char/i2c.c";
+
+  print_diff $kernel_root,$kernel_root,"include/linux/i2c-old.h",=20
+             "include/linux/i2c.h";
+
+
+  open INPUT, "$package_root/mkpatch/OLDI2C"=20
+        or die "Can't open `$package_root/mkpatch/OLDI2C'";
+  @files =3D <INPUT>;
+  close INPUT;
+
+  foreach $f (@files,"drivers/char/i2c-old.c") {
+    $file =3D $f; # Ugly, but seemingly needed to run on Perl 5.6.
+    chomp $file;
+    if ($file eq "drivers/char/i2c-old.c") {
+      open INPUT, "$kernel_root/drivers/char/i2c.c"
+            or next;
+    } else {=20
+      open INPUT, "$kernel_root/$file"
+           or next;
+    }
+    open OUTPUT, ">$package_root/$temp"
+           or die "Can't open `$package_root/$temp'";
+    while (<INPUT>) {
+      s@(\s*#\s*include\s*)<linux/i2c.h>@\1<linux/i2c-old.h>@;
+      print OUTPUT;
+    }
+    close INPUT;
+    close OUTPUT;
+    print_diff $package_root,$kernel_root,$file,$temp;
+  }
+  print_diff "/dev",$kernel_root,"drivers/char/i2c.c","null";
+  gen_drivers_char_Makefile $package_root, $kernel_root;
+}
=20
 # This generates diffs for kernel file Documentation/Configure.help. This
 # file contains the help texts that can be displayed during `make *config'
@@ -273,7 +349,73 @@
   print_diff $package_root,$kernel_root,$kernel_file,$package_file;
 }
=20
+# This generates diffs for the main Linux Makefile.
+# Three lines which add drivers/i2c/i2.a to the DRIVERS list are put just
+# before the place where the architecture Makefile is included.
+# Of course, care is taken old lines are removed.
+# $_[0]: i2c package root (like /tmp/i2c)
+# $_[1]: Linux kernel tree (like /usr/src/linux)
+sub gen_Makefile
+{
+  my ($package_root,$kernel_root) =3D @_;
+  my $kernel_file =3D "Makefile";
+  my $package_file =3D $temp;
+  my $printed =3D 0;
+  my $new_style =3D 0;
+
+  open INPUT,"$kernel_root/$kernel_file"
+        or die "Can't open `$kernel_root/$kernel_file'";
+  open OUTPUT,">$package_root/$package_file"
+        or die "Can't open $package_root/$package_file";
+  MAIN: while(<INPUT>) {
+    if (m@^DRIVERS :=3D@) {
+       $new_style =3D 1;
+    }
+    if (m@DRIVERS-\$\(CONFIG_I2C\)@) {
+      $_ =3D <INPUT>;
+      redo MAIN;
+    } elsif (m@CONFIG_I2C@) {
+      $_ =3D <INPUT> while not m@endif@;
+      $_ =3D <INPUT>;
+      $_ =3D <INPUT> if m@^$@;
+      redo MAIN;
+    }
+    if (not $printed and m@DRIVERS-\$\(CONFIG_PHONE\)@) {
+      if ($new_style) {
+        print OUTPUT << 'EOF';
+DRIVERS-$(CONFIG_I2C) +=3D drivers/i2c/i2c.a
+EOF
+      } else {
+        print OUTPUT << 'EOF';
+DRIVERS-$(CONFIG_I2C) +=3D drivers/i2c/i2c.o
+EOF
+      }
+      $printed =3D 1;
+    } elsif (not $printed and=20
+        (m@include arch/\$\(ARCH\)/Makefile@ or m@CONFIG_SENSORS@ or
+         m@CONFIG_PHONE@ )) {
+      print OUTPUT <<'EOF';
+ifeq ($(CONFIG_I2C),y)
+DRIVERS :=3D $(DRIVERS) drivers/i2c/i2c.a
+endif
+
+EOF
+      $printed =3D 1;
+    }
+    print OUTPUT;
+  }
+  close INPUT;
+  close OUTPUT;
+  die "Automatic patch generation for main `Makefile' failed.\n".
+      "See our home page http://www.lm-sensors.nu for assistance!" if $pri=
nted =3D 0;
+  print_diff $package_root,$kernel_root,$kernel_file,$package_file;
+}
+
 # This generates diffs for drivers/Makefile
+# First, `i2c' is added to the ALL_SUB_DIRS list. Next, a couple of lines
+# to add i2c to the SUB_DIRS and/or MOD_SUB_DIRS lists is put right before
+# Rules.make is included.
+# Of course, care is taken old lines are removed.
 # $_[0]: i2c package root (like /tmp/i2c)
 # $_[1]: Linux kernel tree (like /usr/src/linux)
 sub gen_drivers_Makefile
@@ -284,12 +426,30 @@
   my $i2c_present;
   my $printed =3D 0;
   my $added =3D 0;
+  my $new_style =3D 0;
=20
   open INPUT,"$kernel_root/$kernel_file"
         or die "Can't open `$kernel_root/$kernel_file'";
   open OUTPUT,">$package_root/$package_file"
         or die "Can't open $package_root/$package_file";
   MAIN: while(<INPUT>) {
+    if (m@^mod-subdirs\s*:=3D@) {
+       $new_style =3D 1;
+    }
+    if ((! $new_style and m@^ALL_SUB_DIRS\s*:=3D@) or m@^mod-subdirs\s*:=
=3D@ ) {
+      $added =3D 1;
+      $i2c_present =3D 0;
+      while (m@\\$@) {
+        $i2c_present =3D 1 if m@i2c@;
+        print OUTPUT;
+        $_ =3D <INPUT>;
+      }
+      $i2c_present =3D 1 if m@i2c@;
+      s@$@ i2c@ if (not $i2c_present);
+      print OUTPUT;
+      $_ =3D <INPUT>;
+      redo MAIN;
+    }=20
     if (m@^ifeq.*CONFIG_I2C@) {
       $_ =3D <INPUT> while not m@^endif@;
       $_ =3D <INPUT>;
@@ -300,14 +460,32 @@
       $_ =3D <INPUT>;
       redo MAIN;
     }
+# 2.5 kernels
+#   if (m@^obj.*CONFIG_I2C@) {
+#   }
     if (not $printed and
-        (m@^ifeq \(\$\(CONFIG_ACPI\),y\)$@ or
+        (m@^include \$\(TOPDIR\)/Rules.make$@ or
+         m@^ifeq \(\$\(CONFIG_ACPI\),y\)$@ or
          m@^ifeq \(\$\(CONFIG_SENSORS\),y\)@) or
          m@^subdir-\$\(CONFIG_ACPI\)@) {
+      if ($new_style) {
         print OUTPUT <<'EOF';
 subdir-$(CONFIG_I2C)		+=3D i2c
 EOF
-        $printed =3D 1;
+      } else {
+        print OUTPUT <<'EOF';
+ifeq ($(CONFIG_I2C),y)
+SUB_DIRS +=3D i2c
+MOD_SUB_DIRS +=3D i2c
+else
+  ifeq ($(CONFIG_I2C),m)
+  MOD_SUB_DIRS +=3D i2c
+  endif
+endif
+
+EOF
+      }
+      $printed =3D 1;
     }
     print OUTPUT;
   }
@@ -318,18 +496,48 @@
   print_diff $package_root,$kernel_root,$kernel_file,$package_file;
 }
=20
+# This generates diffs for drivers/char/Makefile
+# It changes all occurences of `i2c.o' to `i2c-old.o'.
+# $_[0]: i2c package root (like /tmp/i2c)
+# $_[1]: Linux kernel tree (like /usr/src/linux)
+sub gen_drivers_char_Makefile
+{
+  my ($package_root,$kernel_root) =3D @_;
+  my $kernel_file =3D "drivers/char/Makefile";
+  my $package_file =3D $temp;
+  open INPUT,"$kernel_root/$kernel_file"
+        or die "Can't open `$kernel_root/$kernel_file'";
+  open OUTPUT,">$package_root/$package_file"
+        or die "Can't open $package_root/$package_file";
+  while(<INPUT>) {
+    s@i2c\.o@i2c-old\.o@;
+    print OUTPUT;
+  }
+  close INPUT;
+  close OUTPUT;
+  print_diff $package_root,$kernel_root,$kernel_file,$package_file;
+}
=20
 # This generates diffs for drivers/i2c/Makefile
+# for either 'old style' or 'new style'.
+# Don't bother putting in 'old style' support for new architectures
+# like 8xx, IBM405, or StrongARM since they aren't supported
+# in old kernels anyway.
 sub gen_drivers_i2c_Makefile
 {
   my ($package_root,$kernel_root) =3D @_;
   my $kernel_file =3D "drivers/i2c/Makefile";
   my $package_file =3D $temp;
   my $use_new_format =3D 0;
+  if (-e "$kernel_root/$kernel_file") {
+    `grep -q -s 'i2c\.o' "$kernel_root/$kernel_file"`;
+     $use_new_format =3D ! $?;
+  }
=20
   open OUTPUT,">$package_root/$package_file"
         or die "Can't open $package_root/$package_file";
-  print OUTPUT <<'EOF';
+  if ($use_new_format) {
+    print OUTPUT <<'EOF';
 #
 # Makefile for the kernel i2c bus driver.
 #
@@ -356,12 +564,168 @@
 obj-$(CONFIG_I2C_IBM_OCP_ADAP)	+=3D i2c-adap-ibm_ocp.o
 obj-$(CONFIG_I2C_FRODO)		+=3D i2c-frodo.o
=20
+# This is needed for automatic patch generation: sensors code starts here
+# This is needed for automatic patch generation: sensors code ends here
+
+include $(TOPDIR)/Rules.make
+
 EOF
+  } else {
+    print OUTPUT <<'EOF';
+#
+# Makefile for the kernel i2c bus driver.
+#
+
+SUB_DIRS     :+MOD_SUB_DIRS :=3D $(SUB_DIRS)
+ALL_SUB_DIRS :=3D $(SUB_DIRS)
+MOD_LIST_NAME :=3D I2C_MODULES
+
+L_TARGET :=3D i2c.a
+MX_OBJS :=3D =20
+M_OBJS  :=3D=20
+LX_OBJS :+L_OBJS  :=3D=20
+
+# -----
+# i2c core components
+# -----
+
+ifeq ($(CONFIG_I2C),y)
+  LX_OBJS +=3D i2c-core.o
+else
+  ifeq ($(CONFIG_I2C),m)
+    MX_OBJS +=3D i2c-core.o
+  endif
+endif
+
+ifeq ($(CONFIG_I2C_CHARDEV),y)
+  L_OBJS +=3D i2c-dev.o
+else
+  ifeq ($(CONFIG_I2C_CHARDEV),m)
+    M_OBJS +=3D i2c-dev.o
+  endif
+endif
+
+ifeq ($(CONFIG_I2C_PROC),y)
+  LX_OBJS +=3D i2c-proc.o
+else
+  ifeq ($(CONFIG_I2C_PROC),m)
+    MX_OBJS +=3D i2c-proc.o
+  endif
+endif
+
+# -----
+# Bit banging adapters...
+# -----
+
+ifeq ($(CONFIG_I2C_ALGOBIT),y)
+  LX_OBJS +=3D i2c-algo-bit.o
+else
+  ifeq ($(CONFIG_I2C_ALGOBIT),m)
+    MX_OBJS +=3D i2c-algo-bit.o
+  endif
+endif
+
+ifeq ($(CONFIG_I2C_PHILIPSPAR),y)
+  L_OBJS +=3D i2c-philips-par.o
+else
+  ifeq ($(CONFIG_I2C_PHILIPSPAR),m)
+    M_OBJS +=3D i2c-philips-par.o
+  endif
+endif
+
+ifeq ($(CONFIG_I2C_ELV),y)
+  L_OBJS +=3D i2c-elv.o
+else
+  ifeq ($(CONFIG_I2C_ELV),m)
+    M_OBJS +=3D i2c-elv.o
+  endif
+endif
+
+ifeq ($(CONFIG_I2C_VELLEMAN),y)
+  L_OBJS +=3D i2c-velleman.o
+else
+  ifeq ($(CONFIG_I2C_VELLEMAN),m)
+    M_OBJS +=3D i2c-velleman.o
+  endif
+endif
+
+
+
+# -----
+# PCF components
+# -----
+
+ifeq ($(CONFIG_I2C_ALGOPCF),y)
+  LX_OBJS +=3D i2c-algo-pcf.o
+else
+  ifeq ($(CONFIG_I2C_ALGOPCF),m)
+    MX_OBJS +=3D i2c-algo-pcf.o
+  endif
+endif
+
+ifeq ($(CONFIG_I2C_ELEKTOR),y)
+  L_OBJS +=3D i2c-elektor.o
+else
+  ifeq ($(CONFIG_I2C_ELEKTOR),m)
+    M_OBJS +=3D i2c-elektor.o
+  endif
+endif
+
+# This is needed for automatic patch generation: sensors code starts here
+# This is needed for automatic patch generation: sensors code ends here
+
+include $(TOPDIR)/Rules.make
=20
+EOF
+  }
   close OUTPUT;
   print_diff $package_root,$kernel_root,$kernel_file,$package_file;
 }
=20
+# This generates diffs for drivers/char/Config.in
+# It adds a line just before CONFIG_APM or main_menu_option lines to inclu=
de
+# the I2C Config.in.
+# Of course, care is taken old lines are removed.
+# $_[0]: i2c package root (like /tmp/i2c)
+# $_[1]: Linux kernel tree (like /usr/src/linux)
+sub gen_drivers_char_Config_in
+{
+  my ($package_root,$kernel_root) =3D @_;
+  my $kernel_file =3D "drivers/char/Config.in";
+  my $package_file =3D $temp;
+  my $ready =3D 0;
+  my $printed =3D 0;
+
+  open INPUT,"$kernel_root/$kernel_file"
+        or die "Can't open `$kernel_root/$kernel_file'";
+  open OUTPUT,">$package_root/$package_file"
+        or die "Can't open $package_root/$package_file";
+  MAIN: while(<INPUT>) {
+    if (m@i2c@) {
+      $_ =3D <INPUT>;
+      $_ =3D <INPUT> if (m@^$@);
+      redo MAIN;
+    }
+    if ($ready and not $printed and=20
+        (m@^mainmenu_option@ or m@CONFIG_APM@ or m@CONFIG_ALPHA_BOOK1@ or
+         m@source drivers/sensors/Config.in@)) {
+      $printed =3D 1;
+      print OUTPUT <<'EOF';
+source drivers/i2c/Config.in
+
+EOF
+    }
+    $ready =3D 1 if (m@^mainmenu_option@);
+    print OUTPUT;
+  }
+  close INPUT;
+  close OUTPUT;
+  die "Automatic patch generation for `drivers/char/Config.in' failed.\n".
+      "See our home page http://www.lm-sensors.nu for assistance!" if $pri=
nted =3D 0;
+  print_diff $package_root,$kernel_root,$kernel_file,$package_file;
+}
 =20
 # Generate the diffs for the list of MAINTAINERS
 # $_[0]: i2c package root (like /tmp/i2c)
@@ -417,6 +781,11 @@
   die "Package root `$package_root' is not found\n"=20
         unless -d "$package_root/mkpatch";
   $kernel_root =3D $ARGV[1];
+  die "Kernel root `$kernel_root' is not found\n"=20
+        unless -f "$kernel_root/Rules.make";
+
+  patch_old_i2c $package_root, $kernel_root;
+        =20
=20
   # --> Read FILES
   open INPUT, "$package_root/mkpatch/FILES"=20
@@ -440,12 +809,21 @@
   # --> Start generating
   foreach $package_file (sort keys %files) {
     $kernel_file =3D $files{$package_file};
+    @sensors_subs =3D find_sensors_code "$kernel_root","$kernel_file";
     open INPUT, "$package_root/$package_file"
          or die "Can't open `$package_root/$package_file'";
     open OUTPUT, ">$package_root/$temp"
          or die "Can't open `$package_root/$temp'";
     while (<INPUT>) {
       eval $sedscript;
+      if (m@sensors code starts here@) {
+        print OUTPUT;
+        while (<INPUT>) {
+           last if m@sensors code ends here@;
+        }
+        print OUTPUT $sensors_subs[0];
+        shift @sensors_subs
+      }
       print OUTPUT;
     }
     close INPUT;
@@ -456,7 +834,9 @@
 #  gen_Makefile $package_root, $kernel_root;
 #  gen_drivers_Makefile $package_root, $kernel_root;
 #  gen_drivers_i2c_Makefile $package_root, $kernel_root;
-#  gen_Documentation_Configure_help $package_root, $kernel_root;
+#  gen_drivers_char_Config_in $package_root, $kernel_root;
+   gen_Documentation_Configure_help $package_root, $kernel_root;
+#  gen_MAINTAINERS $package_root, $kernel_root;
 }
=20
 main;
