From: mds4@verizon.net (Mark Studebaker)
Date: Thu, 19 May 2005 06:25:26 +0000
Subject: Call for 2.9.0
Message-Id: <41B7A4E7.40005@verizon.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <20041208224836.7794b56c.khali@linux-fr.org>
In-Reply-To: <20041208224836.7794b56c.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

1) are you working on sensors README/QUICKSTART/INSTALL updates or are you looking for volunteers?

2) i2c-virtual and pca954x are checked in but not in the Makefiles, pending i2c-core changes required.
   I can do the core changes before or after 2.9.0. Attached is the i2c-core patch,
   slimmed down from that received from Brian Kuschak.
   It's really only two changes:
	- creating xxx_nolock versions of some calls
	- working up the bus tree for busy checks, using i2c_virt_parent()

   Not sure I like the i2c_virt_parent() hack (see kernel/include/i2c-virtual.h in sensors for the definition)
   and trying to think of a better way to do it.

   Anyway, comments on the patch and on the timing (before or after 2.9.0) welcome.

mds



Jean Delvare wrote:
> Hi all,
> 
> I would like us to release i2c 2.9.0 (and obviously lm_sensors 2.9.0)
> quite soon now. Before the end of the year would be great.
> 
> I am done with restoring the compatibility with Linux 2.4. I have an
> update of my installation guide [1] ready (not online yet) for 2.9.0.
> This should have been done one year ago, so better release it as soon as
> possible now.
> 
> I would like everyone using lm_sensors on a 2.4 kernel on a regular
> basis to give a try to i2c-CVS and lm_sensors-CVS now, and report if
> problems arise. This is the biggest change to i2c since 2.8.0 so it
> deserves some texting before we release it.
> 
> This also suggests that no more big changes to the CVS repositories
> should be committed until after the release (unless anyone has prepared
> something for a long time and commits them in the next few days).
> 
> Thanks,
-------------- next part --------------
--- i2c-core.c.orig	Sat Dec  4 22:52:48 2004
+++ i2c-core.c	Wed Dec  8 16:59:43 2004
@@ -78,12 +78,14 @@
  * i2c_add_adapter is called from within the algorithm layer,
  * when a new hw adapter registers. A new device is register to be
  * available for clients.
+ *
+ * i2c_add_adapter_nolock does the actual work.  It is split
+ * out so it can be called externally by i2c-virtual.c without deadlocking.
  */
-int i2c_add_adapter(struct i2c_adapter *adap)
+int i2c_add_adapter_nolock(struct i2c_adapter *adap)
 {
 	int i,j,res = 0;
 
-	down(&core_lists);
 	for (i = 0; i < I2C_ADAP_MAX; i++)
 		if (NULL = adapters[i])
 			break;
@@ -117,16 +119,32 @@
 	DEB(printk(KERN_DEBUG "i2c-core.o: adapter %s registered as adapter %d.\n",
 	           adap->name,i));
 ERROR0:
+	return res;
+}
+
+int i2c_add_adapter(struct i2c_adapter *adap)
+{
+	int res;
+
+	down(&core_lists);
+        res = i2c_add_adapter_nolock(adap);
 	up(&core_lists);
+
 	return res;
 }
 
 
-int i2c_del_adapter(struct i2c_adapter *adap)
+/*
+ * i2c_del_adapter is the corresponding function to detach all clients
+ * for a bus/adapter and then deregister it.
+ *
+ * i2c_del_adapter_nolock does the actual work.  It is split
+ * out so it can be called externally by i2c-virtual.c without deadlocking.
+ */
+int i2c_del_adapter_nolock(struct i2c_adapter *adap)
 {
 	int i,j,res = 0;
 
-	down(&core_lists);
 	for (i = 0; i < I2C_ADAP_MAX; i++)
 		if (adap = adapters[i])
 			break;
@@ -176,7 +194,17 @@
 	adapters[i] = NULL;
 	DEB(printk(KERN_DEBUG "i2c-core.o: adapter unregistered: %s\n",adap->name));
 ERROR0:
+	return res;
+}
+
+int i2c_del_adapter(struct i2c_adapter *adap)
+{
+	int res;
+
+	down(&core_lists);
+        res = i2c_del_adapter_nolock(adap);
 	up(&core_lists);
+
 	return res;
 }
 
@@ -297,13 +325,21 @@
 	return res;
 }
 
-static int __i2c_check_addr (struct i2c_adapter *adapter, int addr)
+static int i2c_check_addr_nolock (struct i2c_adapter *adapter, int addr)
 {
 	int i;
-	for (i = 0; i < I2C_CLIENT_MAX ; i++) 
+
+#if defined(CONFIG_I2C_VIRTUAL) || defined(CONFIG_I2C_VIRTUAL_MODULE)
+	/* Must check for aliasing on i2c-multiplexed busses since a virt
+         * bus will always appear to have its own mux as an address.  Without
+         * this check we can get infinite recursion during bus scans.
+         */
+	for ( ; adapter; adapter = i2c_virt_parent(adapter))
+#endif
+            for (i = 0; i < I2C_CLIENT_MAX ; i++) {
 		if (adapter->clients[i] && (adapter->clients[i]->addr = addr))
 			return -EBUSY;
-
+            }
 	return 0;
 }
 
@@ -312,7 +348,7 @@
 	int rval;
 
 	down(&adapter->list);
-	rval = __i2c_check_addr(adapter, addr);
+	rval = i2c_check_addr_nolock(adapter, addr);
 	up(&adapter->list);
 
 	return rval;
@@ -1470,6 +1506,8 @@
 
 EXPORT_SYMBOL(i2c_add_adapter);
 EXPORT_SYMBOL(i2c_del_adapter);
+EXPORT_SYMBOL(i2c_add_adapter_nolock);
+EXPORT_SYMBOL(i2c_del_adapter_nolock);
 EXPORT_SYMBOL(i2c_add_driver);
 EXPORT_SYMBOL(i2c_del_driver);
 EXPORT_SYMBOL(i2c_attach_client);
