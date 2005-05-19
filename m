From: mds@mds.gotdns.com (Mark Studebaker)
Date: Thu, 19 May 2005 06:25:52 +0000
Subject: NCLV-D SMBus - proposal to a solution
Message-Id: <42640A6F.1040401@mds.gotdns.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <4262C492.10808@sh.cvut.cz>
In-Reply-To: <4262C492.10808@sh.cvut.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jean Delvare wrote:
> Hi Mark,
> 
> 
>>This is a good time to bring up the i2c-virtual driver as an
>>alternative to the -s4882.c style of multiplexing driver. I believe
>>this is a cleaner and more general approach to bus multiplexing.
> 
> 
> I agree it is more general, and possibly cleaner as a result. However,
> it will fail to be as flexible as the s4882 style approach.
> 
> The S4882 has 8 busses, 2 for each CPU. The 2 busses of each CPU are
> "compatible" (no common address) so I merged them, which results in
> better performance (less switching required) and lower memory footprint.
> I don't think you'll be able to do that with the i2c-virtual approach.
> 
> In the NCLV-D case, it has 4 different bus lines, but we only really
> want to handle 2. How can you do that with i2c-virtual?
> 

i2c-virtual is the generic part. It would be handled in a new
nclv-d  module for the specifics of that board.

> Also, I think I remember that i2c-virtual somehow assumes that the
> multiplexer itself is an i2c chip, right? This is not the case for the
> NCLV-D.
> 

no the mux itself can be anything. 
It is controlled by another driver which does the  specific
switching. See pca954x.c.
i2c-virtual.c only contains the generic part.

While pca954x is large, it is overly complex and needs a lot of cleanup.
I belive a module for NCLV could be fairly small.

> 
> 
>>The i2c-virtual driver is checked in to sensors but the small changes
>>required to i2c-core.c are not checked in. I held off late last year
>>because 2.9.0 was coming out soon. Now that 2.9.1 is out it's  time to
>>look at it again. I have to rework the i2c-core changes because they
>>conflicted with other recent changes to i2c-core.
> 
> 
> Yeah, I remember that.
> 
> The more I think of it, the more obvious it is that such a change
> doesn't belong to the 2.4 kernel, but 2.6. I do not want any more
> changes to the i2c subsystem of Linux 2.4 (except for bug fixes and
> documentation updates, of course). It's more than time to move the
> development effort to 2.6, and only do support on 2.4.
> 
> 

well it's a modest change and CVS / 2.4 is a better sandbox to
test out the changes, at least for  me. 2.4 was where the virtual driver was developed
by the original submitter Ken Harrenstein.

>>attached are the proposed changes to i2c-core for comment.
> 
> 
> Eerk. By brain doesn't read non-unified patches very well, sorry.
> 

eerk :) here is unified diff


-------------- next part --------------
--- i2c-core.c.orig	Mon Apr 18 11:21:27 2005
+++ i2c-core.c	Thu Apr  7 12:55:35 2005
@@ -86,12 +86,14 @@
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
@@ -127,16 +129,32 @@
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
@@ -186,7 +204,17 @@
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
 
@@ -310,10 +338,18 @@
 static int __i2c_check_addr (struct i2c_adapter *adapter, int addr)
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
 
@@ -1478,6 +1514,8 @@
 
 EXPORT_SYMBOL(i2c_add_adapter);
 EXPORT_SYMBOL(i2c_del_adapter);
+EXPORT_SYMBOL(i2c_add_adapter_nolock);
+EXPORT_SYMBOL(i2c_del_adapter_nolock);
 EXPORT_SYMBOL(i2c_add_driver);
 EXPORT_SYMBOL(i2c_del_driver);
 EXPORT_SYMBOL(i2c_attach_client);
